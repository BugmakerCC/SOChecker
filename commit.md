basicBlock.py

	•	Naming Convention: Updated variable and method names to be more expressive and consistent, such as changing add_eqexpression to add_eq_expression.
	•	Code Duplication Reduction: Merged similar methods to ensure a more concise expression.
	•	Readability Improvement: Improved code comprehensibility through more structured naming and simplified methods.
	•	Display Method Optimization: The display method now provides more informative output, making it easier to debug.

analysis_unit.py

	•	Clearer Naming: Improved variable and method names for clarity, such as renaming contractRes to contract_results and pass_compile to passed_compilation to better reflect their purpose.
	•	Method Grouping: Grouped methods logically, such as by contracts, functions, AST, etc., to make them easier to understand and maintain.
	•	Code Duplication Reduction: Made shallow copying explicit in methods like copy_to_analysis to avoid potential issues with direct assignments.
	•	Boolean State Updates: Renamed methods to more clearly express their functionality, such as mark_passed_compilation and mark_not_over_time.

graph.py

	•	Code Style: Improved variable names for precision, maintained consistent naming rules, and removed unnecessary blank lines.
	•	Documentation and Comments: Since the graph methods were self-written, added clear and standardized English comments for each method and key sections.

generator.py

	•	Class and Method Names: Renamed the Generator class to VariableGenerator and method names to be more descriptive, such as changing gen_stack_var to generate_stack_variable.
	•	Docstrings: Added detailed docstrings for each method, describing the input, output, and functionality of the methods.
	•	Consistency: Maintained consistency in variable and method naming.

utils.py

	•	Function Naming: Followed more descriptive naming conventions, such as changing isSymbolic to is_symbolic and isReal to is_real.
	•	Docstrings: Added detailed docstrings for each function, describing the parameters, return values, and functionality.

handlejson.py

	•	Constant Naming: Renamed path and configuration constants to uppercase.
	•	Docstrings and Comments: Added comments to path constants and variables to explain their purpose and improve code readability.
	•	Import Sorting: Ordered import statements according to standard libraries, third-party libraries, and local modules.
	•	Code Refactoring: Separated and refactored the part that reads tags, which affected readability.

statistic.py

	•	Refactoring Completed: Refactored the tag data logging process.