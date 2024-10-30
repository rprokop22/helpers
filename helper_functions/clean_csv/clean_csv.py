import pandas as pd
from io import StringIO

def fix_tabs_in_file(file_path, output_file_path, start_row, chunksize=100000) -> pd.DataFrame:
    delimiter = '\t'
    
    bad_lines = []
    line_number = start_row

    with open(file_path,'r') as file:
        while True:
            lines = [next(file,None) for _ in range(chunksize)]

            if not any(lines):
                break
            data = ''.join(str(lines))

            try:
                df = pd.read_csv(StringIO(data), delimiter=delimiter, quoting=3)
                print(f"{line_number} - {line_number + chunksize} chunk read successfully")
                
            except pd.errors.ParserError as e:
                for i,line in enumerate(lines):
                    try:
                        print(line)
                        df = pd.read_csv(StringIO(line), delimiter=delimiter, quoting=3)            
                        # pd.read_csv(StringIO(line), delimiter=delimiter, header=None, quoting=3)
                        print(df)
                    except Exception as e:
                        print(e)
                        bad_lines.append((line_number+i+1, str(e)))
            except Exception as e:
                bad_lines.append((line_number + 1, str(e)))

            line_number += chunksize
    return bad_lines



# def check_file(file_path, output_file_path,start_row,chunksize=100000) -> None:
#     delimeter = '\t'

#     line_number = 0
#     version = 1

#     with open(file_path, 'r') as file:
#         while True:
#             print(f"writing file from {line_number} to {line_number + chunksize}")
#             lines = [next(file,None) for _ in range(chunksize)]
#             if not any(lines):
#                 break
#             data = ''.join(str(lines))

#             try:
#                 with open(output_file_path + f"part_{version}", 'w') as output_file:
#                     output_file.write(data)

                
#                 print(f"write complete for line numbers {line_number} to {line_number + chunksize}")
#             except Exception as e:
#                 print("could not write output")
#                 df = pd.read_csv(StringIO(data), delimiter=delimeter, quoting=3)


#             line_number += chunksize
            


# def check_file(file_path, output_file_path, start_row, chunksize=20000) -> pd.DataFrame:
#     delimiter = '\t'
    
#     bad_lines = []
#     line_number = start_row

#     with open(file_path,'r') as file:
#         while True:
#             lines = [next(file,None) for _ in range(chunksize)]

#             if not any(lines):
#                 break
#             data = ''.join(str(lines))

#             try:
#                 df = pd.read_csv(StringIO(data), delimiter=delimiter, header=None)
#                 print(line_number)
#             except pd.errors.ParserError as e:
#                 for i,line in enumerate(lines):
#                     try:
#                         print(line)
#                         df = pd.read_csv(StringIO(line), delimiter=delimiter, quoting=3)            
#                         # pd.read_csv(StringIO(line), delimiter=delimiter, header=None, quoting=3)
#                     except Exception as e:
#                         print(e)
#                         bad_lines.append((line_number+i+1, str(e)))
#             except Exception as e:
#                 bad_lines.append((line_number + 1, str(e)))

#             line_number += chunksize
#     return bad_lines




def check_file(file_path, output_file_path, start_row=1):
    errors = []
    
    with open(file_path, 'r') as file:
        header = file.readline().strip()
        if not header:
            errors.append((1, "Empty header", ""))
            return
        
        # Determine the expected number of fields from the header
        expected_num_fields = len(header.split('\t'))
        
        # Skip rows until the start_row
        for i, line in enumerate(file, start=start_row+1):
            if i < start_row:
                continue
            
            line = line.strip()
            fields = line.split('\t')
            if len(fields) != expected_num_fields:
                errors.append((i, f"Expected {expected_num_fields} fields but found {len(fields)}", line))
    
    with open(output_file_path, 'w') as output_file:
        if not errors:
            output_file.write("All rows are valid.\n")
        else:
            for error in errors:
                row_num, error_msg, row = error
                output_file.write(f"Row {row_num}: Error '{error_msg}' - {row}\n")

if __name__ == "__main__":
    file_path = '/Users/robbie/Documents/validation/nba_warriors/warriors202410271923_1_custF.TXT'
    # file_path = 'test_files/Pelicans_601-customer_pelicans_20240825080848.TXT'
    # file_path = 'test_files/Pelicans_601-customer_pelicans_20240826080705.TXT'
    output_file_path = '/Users/robbie/Documents/validation/nba_warriors/customers_data/'
    start_row = 0
    check_file(file_path, output_file_path, start_row)
    # bad_lines = fix_tabs_in_file(file_path, output_file_path, start_row)


    # print(bad_lines)
