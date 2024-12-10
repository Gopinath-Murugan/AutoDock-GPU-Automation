# Automated Docking Script for AutoDock-GPU

This repository contains a Bash script (`adt_gpu_automate.sh`) for automating molecular docking simulations using AutoDock-GPU.

## Prerequisites

Before using this script, ensure the following:

1. **Operating System**: The script is designed to run on Linux systems.
2. **Software Requirements**:
   - [AutoDock-GPU](https://ccsb.scripps.edu/autodock-gpu/): Ensure it is installed and added to your `PATH`.
   - [MGLTools](https://ccsb.scripps.edu/mgltools/): Install to access the `pythonsh` and preparation scripts.
   - CUDA must be installed and configured and ensure the correct version of CUDA for your GPU driver.
3. **Hardware Requirements**:
   - Your system should have GPU cards to use this script effectively. Examples of compatible GPUs include:
     - NVIDIA GeForce RTX 30 Series (e.g., RTX 3080, RTX 3090)
     - NVIDIA Quadro RTX Series (e.g., Quadro RTX 6000)
     - NVIDIA Tesla GPUs (e.g., Tesla V100, Tesla T4)

## Preparation Steps

Follow these steps to set up your environment and prepare for running the script:

1. **Create a Working Directory**:

   - Create a new directory to store all the required files and results.

2. **Copy Required Files**:

   - Place the `protein.pdb` file (target protein structure) in the directory.
   - Place the ligand PDB files in the directory. These files should:
     - Be in `.pdb` format.
     - Be energy minimized.

3. **Copy Template Files**:

   - Include a template `.gpf` (grid parameter file) in the same directory.
   - **Ensure the correct values of grid center and grid points (`npts`)** in the `.gpf` file. The grid center and the number of grid points define the docking region and should be adjusted based on the protein structure and ligand to ensure proper docking results.

4. **Copy Python Scripts**:

   - Ensure the directory contains the Python scripts used by the script:
     - `prepare_receptor4.py`
     - `prepare_ligand4.py`
     - `prepare_gpf4.py`

5. **Run the Script**:

   - Execute the script using the command:
     ```bash
     ./adt_gpu_automate.sh
     ```

6. **Analyze Results**:

   - After the script finishes, review the generated docking results and log files in the respective ligand directories.

## Output

- Each ligand will have its own directory containing the processed files and docking results, including:
  - Prepared receptor (`protein.pdbqt`)
  - Prepared ligand (`ligand_name.pdbqt`)
  - Grid map files and logs (`grid.gpf`, `grid.glg`)
  - Docking log files (`dock.log`)

## Notes

- Ensure all input files are correctly formatted and named as expected by the script.
- Modify the script to adjust parameters (e.g., grid size, number of runs) as needed for your specific docking experiments.
- AutoDock-GPU provides faster docking simulations compared to traditional AutoDock, leveraging GPU acceleration for improved performance.

## Example Run

This repository includes example files for reference:
- `protein.pdb` (sample protein structure)
- Ligand PDB files (sample ligands in `.pdb` format)
- Template `.gpf` file
- Python preparation scripts

You can use these files to test the script and understand its workflow.

## Citation

If you are using this script for your studies, kindly acknowledge the use of AutoDock-GPU as per its citation guidelines and mention my GitHub repository:

Santos-Martins, Diogo, et al. "Accelerating AutoDock4 with GPUs and gradient-based local search." Journal of chemical theory and computation 17.2 (2021): 1060-1073. https://pubs.acs.org/doi/10.1021/acs.jctc.0c01006

For the latest version of this script and updates, visit my GitHub repository:
https://github.com/Gopinath-Murugan/AutoDock-GPU-Automation

Mentioning this repository in your publications or research would be greatly appreciated.

We appreciate your support!
