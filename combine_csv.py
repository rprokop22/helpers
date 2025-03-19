import pandas as pd
import os
import glob

def combine_excel_files(input_folder, output_file):
    """
    Combines multiple CSV files from a folder into a single CSV file,
    ensuring only one header is retained.
    
    Parameters:
        input_folder (str): Path to the folder containing CSV files.
        output_file (str): Path to save the combined CSV file.
    """
    excel_files = glob.glob(os.path.join(input_folder, "*.xlsx"))
    
    if not excel_files:
        print("No CSV files found in the specified folder.")
        return

    combined_df = pd.concat((pd.read_excel(f) for f in excel_files), ignore_index=True)

    # combined_df = pd.concat((pd.read_csv(f, encoding='ISO-8859-1') for f in csv_files), ignore_index=True)
    # combined_df.to_csv(output_file, index=False, encoding='utf-8')
    outpath = f"{output_file}/combined.xlsx"
    with pd.ExcelWriter(outpath, engine="xlsxwriter") as writer:

        combined_df.to_excel(writer, index=True)
    print(f"Combined CSV saved as: {output_file}")

if __name__ == "__main__":
    input_folder = input("path to your xlsx files: ")
    output_file = input("output path: ")
    combine_excel_files(input_folder, output_file)