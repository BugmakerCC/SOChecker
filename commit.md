basicBlock.py

	•	Naming Convention: Renamed variables and methods to be more expressive and consistent, e.g., add_eqexpression changed to add_eq_expression.
	•	Code Duplication Reduction: Merged some similar methods to make the expressions more concise.
	•	Readability Improvement: Improved code readability through more structured naming and simplified methods.
	•	Display Method Optimization: The display method now provides more informative output, making debugging easier.

analysis_unit.py

	•	Clearer Naming: Improved clarity by renaming variables and methods, e.g., contractRes renamed to contract_results, pass_compile to passed_compilation, to better reflect their purpose.
	•	Method Grouping: Grouped related methods, such as contracts, functions, and ASTs, making it easier to understand and maintain.
	•	Code Duplication Reduction: Made shallow copy operations explicit in the copy_to_analysis method to avoid potential issues from direct assignment.
	•	Boolean State Update: Renamed methods to more clearly express their function, such as mark_passed_compilation and mark_not_over_time.

graph.py

	•	Code Style: Improved variable naming with more precise terms, maintained consistent naming rules, and removed unnecessary blank lines.
	•	Documentation and Comments: Since the graph methods are custom-written, added clear and standard English comments for each method and key parts.

generator.py

	•	Class and Method Naming: Renamed the Generator class to VariableGenerator and used more descriptive method names, such as renaming gen_stack_var to generate_stack_variable.
	•	Docstrings: Added detailed docstrings for each method, describing the input, output, and function of the methods.
	•	Consistency: Maintained consistency in variable and method naming.

utils.py

	•	Function Naming: Followed more descriptive naming conventions, e.g., isSymbolic renamed to is_symbolic, isReal to is_real.
	•	Docstrings: Added detailed docstrings for each function, describing parameters, return values, and functionality.

handlejson.py

	•	Constant Naming: Renamed path and configuration constants to all uppercase.
	•	Docstrings and Comments: Added comments for path constants and variables to explain their purpose, improving code readability.
	•	Import Sorting: Sorted import statements according to standard libraries, third-party libraries, and local modules.