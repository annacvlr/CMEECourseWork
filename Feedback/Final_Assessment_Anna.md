
# Final CMEE Bootcamp Assessment: Anna Cavalieri Canosa

- You consistently improved the organization of project files over the weeks.
- README files evolved to include more detailed and structured information about the weekly tasks and dependencies - at the end they were too verbose; over time you will learn to find the right balance.

## Week  1

 - Basic README file present with a summary of Week 1 activities; lacked details on installation and usage of scripts.
 - Directories `code`, `data`, `results`, and `sandbox` were appropriately structured.
 - Shell scripting tasks were foundational but effective in illustrating basic concepts.
  - `variables.sh`: Encountered syntax errors due to missing arguments.
  - `tiff2png.sh`: Failed when no `.tif` files were found in the test environment.

## Week  2

   
 - Directories were consistent with project standards.
 - README could include examples of script input/output.
 - Docstrings were added to scripts like `cfexercises1.py`, enhancing clarity.
 - `align_seqs.py`: Lacked proper error handling for invalid input files.

## Week  3

   
 - README provided good details about R tasks, dependencies, and package installation; could include troubleshooting tips or challenges faced during the week's tasks.
 - Results folder was better maintained, avoiding unnecessary files.
 - `Florida.R`: Lots of unnecessary commands included, and Latex report was for some reason included here!
  - The `Florida.R` script OK, implementing permutation testing and visualizing temperature trends.
    - The use of vectorized operations minimized computational overhead.
     - Lots of unnecessary basic R commands in the code!
     - p-value is incorrectly calculated - please see solution script.
     - Add inline comments to clarify the rationale behind each major step.
    - The LaTeX report was concise (not clear why it was included in the R script).
    - Expand the discussion to include potential climatic implications of the observed warming trend.
 - `PP_Regress.R`: Could benefit from inline comments explaining data filtering steps.
  - Autocorrelation practical was OK, with some tweaks needed - please compare your p-value calculations with the solutions provided. The code was succinct and it was reasonably efficient . Include inline comments to explain the purpose an rationale of the statistical test.

---

## Git Practices

- Commit frequency and detail improved over the weeks.
- `.gitignore` was introduced in Week 2 - better late than never!

### Areas for Improvement:
1. **Commit Messages**:
   - Early commits lacked detail (e.g., "update script"). Use descriptive messages such as "Refactor Florida.R to improve error handling."
2. **Branching**:
   - Feature branches could enhance workflow efficiency and isolate major changes.

---

## Overall Assessment

Overall a good job! 

You demonstrated significant growth in programming skills, workflow organization, and documentation over the course of the bootcamp. The Florida autocorrelation practical had several issues. There were also some errors across the weeks that could have been easily fixed.

Your commenting is very thorough, perhaps a little too much so, but this will improve with experience.

Some of your scripts did retain errors. Try to be a little more vigilant in chasing down errors in future.

It was a tough set of weeks, but I believe your hard work in them has given you a great start towards further training, a quantitative masters dissertation, and ultimately a career in quantitative biology! 

### (Provisional) Mark
 *67*