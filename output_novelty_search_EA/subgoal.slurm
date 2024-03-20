#!/bin/bash
#SBATCH --job-name=Subgoal_PointMaze
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user="s3507637@vuw.leidenuniv.nl"
#SBATCH --mail-type="ALL"
#SBATCH --partition="gpu-medium"
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1
#SBATCH --mem=20G
#SBATCH --gpus=1

echo "#### Starting Test"
echo "This is $SLURM_JOB_USER and my first job has the ID $SLURM_JOB_ID"
# get the current working directory
CWD=$(pwd)
echo "This job was submitted from $SLURM_SUBMIT_DIR and I am currently in $CWD"
# get the current time and date
DATE=$(date)
echo "It is now $DATE"
echo "Hello World from $HOSTNAME"

ml purge
ml load shared DefaultModules Miniconda3 gcc slurm CUDA/11.3.1 GCC/9.3.0 FFmpeg

conda init bash
source ~/.bashrc

conda activate peg
cd ~
cd data1/peg

echo "[$SHELL] Using GPU: "$CUDA_VISIBLE_DEVICES

export PYTHONPATH=/home/s3507637/data1/mrl
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/s3507637/.mujoco/mujoco210/bin
export MUJOCO_GL=egl 
export MUJOCO_RENDERER=egl

# python $HOME/data1/peg/examples/run_goal_cond.py --configs peg_point_maze --logdir ~/logdir/peg_point_maze_novelty
python $HOME/data1/peg/examples/run_goal_cond.py --configs peg_point_maze --goal_strategy "SubgoalPlanner" --logdir ~/logdir/Subgoal_PointMaze


echo "#### Finished training :)"

# get the current time and date
DATE=$(date)
echo "It is now $DATE"