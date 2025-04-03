# PowerShell script to optimize the environment for Bible LLM

# Step 1: Check if Anaconda is installed
if (-not (Get-Command conda -ErrorAction SilentlyContinue)) {
    Write-Host "Anaconda is not installed. Please install Anaconda first from https://www.anaconda.com/."
    exit 1
}

# Step 2: Create a new Conda environment named 'bible-llm' with Python 3.8
Write-Host "Creating Conda environment 'bible-llm' with Python 3.8..."
conda create -n Bible-llm python=3.8 -y

# Step 3: Install required packages in the new environment
Write-Host "Installing 'tensorflow' and 'transformers' in 'bible-llm'..."
conda run -n Bible-llm pip install tensorflow transformers

# Step 4: Define the directory with the 66 book text files and the output file
$booksDir = "books"
$outputFile = "bible.txt"

# Check if the 'books' directory exists
if (-not (Test-Path $booksDir)) {
    Write-Host "Directory '$booksDir' not found. Please ensure your 66 text files are in the 'books' directory."
    exit 1
}

# Step 5: Combine all .txt files in the 'books' directory into 'bible.txt'
Write-Host "Combining all text files from '$booksDir' into '$outputFile'..."
Get-ChildItem -Path $booksDir -Filter *.txt | ForEach-Object {
    Get-Content $_.FullName | Add-Content $outputFile
}

# Step 6: Confirm completion and provide activation instructions
Write-Host "Environment setup complete."
Write-Host "To use the environment, run: conda activate bible-llm"
Write-Host "'$outputFile' is ready for use in your LLM project."
