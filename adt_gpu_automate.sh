#!/bin/bash
# Display a header message about the script
cat << "EOF"
            ########################################################################## 
            ##                                                                      ##
            ##               Automated Docking Script for AutoDock-GPU              ##
            ##                   Written by Gopinath Murugan                        ##
            ##       CAS in Crystallography and Biophysics, University of Madras    ##
            ##                   Email: murugangopinath12@gmail.com                 ##
            ##                                                                      ##  
            ########################################################################## 
EOF

# Ensure the script is run using bash.

# Iterate over all PDB files in the current directory.
for f in ./*.pdb; do
    # Extract the base name of the ligand (file name without extension).
    lig=$(basename "$f" .pdb)
    
    # Skip the file named protein.pdb.
    if [ "$lig" == "protein" ]; then
        echo "Skipping protein.pdb"
        continue
    fi
    
    # Print a message indicating the start of docking for this ligand.
    echo "Processing docking for $lig"
    
    # Create a directory for the ligand if it does not already exist.
    mkdir -p "$lig"
    
    # Change to the ligand directory.
    (
        cd "$lig" || { echo "Failed to change directory to $lig"; exit 1; }
        
        # Copy required files into the ligand directory.
        cp ../"$lig".pdb ./ ||
            { echo "Failed to copy $lig.pdb"; exit 1; }
        cp ../protein.pdb ./ ||
            { echo "Failed to copy protein.pdb"; exit 1; }
               
        # Prepare receptor for AutoDock.
        pythonsh ../prepare_receptor4.py -r protein.pdb -o protein.pdbqt ||
            { echo "Failed to prepare receptor"; exit 1; }
        
        # Prepare ligand for AutoDock.
        pythonsh ../prepare_ligand4.py -l "$lig".pdb -o "$lig".pdbqt ||
            { echo "Failed to prepare ligand $lig"; exit 1; }
        
        # Prepare grid parameter file for AutoDock-GPU.
        pythonsh ../prepare_gpf4.py -l "$lig".pdbqt -r protein.pdbqt -p npts="45,45,45" -i ./../g.gpf -o grid.gpf ||
            { echo "Failed to prepare grid parameter file"; exit 1; }
       
	    # Run AutoGrid to generate the grid maps.
   	    (autogrid4 -p grid.gpf -l grid.glg &) &&

	    # Wait for AutoGrid to complete (adjust time as necessary).
 	    sleep 10 && 
		
        # Run AutoDock-GPU.
        echo "Starting AutoDock-GPU for $lig"
        autodock_gpu_128wi --ffile protein.maps.fld --lfile "$lig".pdbqt --nrun 100 --nev 2500000 --gbest ||
            { echo "AutoDock-GPU failed for $lig"; exit 1; }
    )
done

# Final message indicating completion
echo "All docking processes have been completed successfully."

