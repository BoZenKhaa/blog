# PDF editing and Inkscape
 The ultimate open-source vector graphics editor.

## Inkscape
### Install Inkscape
Just follow directions. 

Add to "Open with" menu in Windows: place a shortcut to Inkscape in `C:\ProgramData\Microsoft\Windows\Start Menu\Programs`.

### Rotate pages of PDF
1. Open PDF in Inkscape
2. Click twice on page until rotation handles appear
3. Rotate page
4. Edit -> Resize page to selection (or Ctrl+Shift+R)
5. Save


## Split PDF with `pdfseparate`

From https://xgueret.github.io/en/posts/pdfseparate/

Install in WSL: 
```Bash
sudo apt install poppler-utils
```

Simple usage:
```Bash
pdfseparate input.pdf output-%d.pdf
```
`output-%d.pdf` specifies the naming pattern for the generated files, where %d will be replaced by the page number.

Split into four-page parts, use `qpdf` and this script:
```Bash
#!/bin/bash

# This script splits a PDF file into multiple, smaller PDF files,
# each containing a specified number of pages.

# --- Functions ---

# Function to display usage information and exit
usage() {
    echo "Error: $1"
    echo ""
    echo "Usage: $0 <input_pdf_file> <pages_per_chunk>"
    echo "Example: $0 my_document.pdf 4"
    exit 1
}

# --- Argument Validation ---

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
    usage "Incorrect number of arguments."
fi

INPUT_FILE="$1"
PAGES_PER_CHUNK="$2"

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
    usage "File not found: $INPUT_FILE"
fi

# Check if pages_per_chunk is a positive number
if ! [[ "$PAGES_PER_CHUNK" =~ ^[1-9][0-9]*$ ]]; then
    usage "Pages per chunk must be a positive number (e.g., 1, 4, 10)."
fi

# --- Check Dependencies ---

# Check if qpdf is installed
if ! command -v qpdf &> /dev/null; then
    echo "Error: 'qpdf' is not installed."
    echo "Please install it with: sudo apt install qpdf"
    exit 1
fi

# Check if pdfinfo is installed
if ! command -v pdfinfo &> /dev/null; then
    echo "Error: 'pdfinfo' is not installed."
    echo "It is part of the 'poppler-utils' package."
    echo "Please install it with: sudo apt install poppler-utils"
    exit 1
fi

# --- Configuration ---

# Get the filename without the .pdf extension to use as a prefix
# Example: /home/user/my_doc.pdf -> my_doc
BASENAME=$(basename "$INPUT_FILE" .pdf)
OUTPUT_PREFIX="${BASENAME}_part"

# --- Main Script ---

# 1. Get the total number of pages
TOTAL_PAGES=$(pdfinfo "$INPUT_FILE" | grep "Pages:" | awk '{print $2}')

if [ -z "$TOTAL_PAGES" ]; then
    echo "Error: Could not get page count from $INPUT_FILE."
    exit 1
fi

echo "Splitting '$INPUT_FILE' ($TOTAL_PAGES pages) into ${PAGES_PER_CHUNK}-page chunks..."

# 2. Loop through the document
CHUNK_NUM=1
START_PAGE=1

while [ $START_PAGE -le $TOTAL_PAGES ]; do
    
    # Calculate the end page for this chunk
    END_PAGE=$((START_PAGE + PAGES_PER_CHUNK - 1))

    # Adjust the end page if it goes beyond the total pages
    if [ $END_PAGE -gt $TOTAL_PAGES ]; then
        END_PAGE=$TOTAL_PAGES
    fi

    # Format the output filename (e.g., my_doc_part_001.pdf)
    OUTPUT_FILE=$(printf "%s_%03d.pdf" "$OUTPUT_PREFIX" $CHUNK_NUM)

    echo "  -> Creating $OUTPUT_FILE (Pages $START_PAGE-$END_PAGE)"

    # 3. Run qpdf to extract the range into a *single* file
    qpdf "$INPUT_FILE" --pages . $START_PAGE-$END_PAGE -- "$OUTPUT_FILE"

    # Set the start page for the next loop
    START_PAGE=$((END_PAGE + 1))
    CHUNK_NUM=$((CHUNK_NUM + 1))

done

echo "Done. All parts saved with prefix '${OUTPUT_PREFIX}'."
```


Optimizing pdf so that the splits are not the same size as oroginal, via Ghostscript: 
```Bash
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=doc-compressed.pdf doc.pdf
```
after which pdfseparate lead to the expected size reduction.


