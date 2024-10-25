import sys
import os
def read_fasta(file_path):
    """Read a FASTA file and return the sequence, or raise an error if the file is not found."""
    try:
        with open(file_path, 'r') as file:
            lines = file.readlines()
            # Return the sequence, skipping the header line
            return ''.join(line.strip() for line in lines[1:])
    except FileNotFoundError:
        print(f"Error: The file {file_path} was not found.")
        sys.exit(1)

def assign_sequences(seq1, seq2):
    """Return the longer and shorter sequences."""
    return (seq1, seq2) if len(seq1) >= len(seq2) else (seq2, seq1)

def calculate_score(s1, s2, startpoint):
    """Calculate alignment score and generate alignment representation."""
    matched = []
    score = 0

    for i in range(len(s2)):
        if (i + startpoint) < len(s1):
            if s1[i + startpoint] == s2[i]:
                matched.append("*")
                score += 1
            else:
                matched.append("-")
    
    return ''.join(matched), score

def find_best_alignment(s1, s2):
    """Find the best alignment for two sequences."""
    best_align = None
    best_score = -1

    for i in range(len(s1)):
        matched, score = calculate_score(s1, s2, i)
        if score > best_score:
            best_align = "." * i + s2
            best_score = score

    return best_align, best_score

def main():
    if len(sys.argv) != 3:
        print("Usage: python align_seqs_fasta.py <407228326.fasta> <407228412.fasta>")
        sys.exit(1)

    # Read sequences from the provided FASTA files
    seq_file1_path = sys.argv[1]
    seq_file2_path = sys.argv[2]
    seq1 = read_fasta(seq_file1_path)
    seq2 = read_fasta(seq_file2_path)

    # Assign longer and shorter sequences
    s1, s2 = assign_sequences(seq1, seq2)

    # Find the best alignment
    best_align, best_score = find_best_alignment(s1, s2)

    # Output the results to console
    print("Best Alignment:")
    print(best_align)
    print(s1)
    print(f"Best Score: {best_score}")

    # Output the results to a file
    output_file = f"../results/best_alignment_{os.path.basename(seq_file1_path)}_vs_{os.path.basename(seq_file2_path)}.txt"
    with open(output_file, 'w') as f:
        f.write("Best Alignment:\n")
        f.write(best_align + "\n")
        f.write(s1 + "\n")
        f.write(f"Best Score: {best_score}\n")

if __name__ == "__main__":
    main()

