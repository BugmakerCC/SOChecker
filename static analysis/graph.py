from collections import defaultdict, deque

class Graph:
    """
    This class represents a directed graph using adjacency list representation.
    It supports operations such as adding edges, detecting cycles using topological sort,
    and finding all cycles through a depth-first search.
    """

    def __init__(self):
        """
        Initializes an empty graph using a default dictionary where each node 
        maps to a list of its neighbors.
        """
        self.graph = defaultdict(list)

    def add_edge(self, u, v):
        """
        Adds a directed edge from node `u` to node `v` in the graph.
        
        :param u: The start node of the edge
        :param v: The destination node of the edge
        """
        self.graph[u].append(v)

    def detect_cycles_via_topological_sort(self, all_nodes):
        """
        Detects cycles in the graph using Kahn's Algorithm for topological sorting.
        Nodes that cannot be processed in a topological order (i.e., nodes that are
        part of a cycle) are identified.

        :param all_nodes: A list of all nodes in the graph
        :return: A list of nodes that are part of a cycle
        """
        in_degree = {node: 0 for node in all_nodes}
        for node in self.graph:
            for neighbor in self.graph[node]:
                if neighbor in in_degree:
                    in_degree[neighbor] += 1

        visited = {node: False for node in all_nodes}
        cycle_nodes = []

        # Queue initialization with nodes having in-degree of 0 (no incoming edges)
        zero_in_degree_queue = deque([node for node in in_degree if in_degree[node] == 0])

        while zero_in_degree_queue:
            current_node = zero_in_degree_queue.popleft()
            visited[current_node] = True
            for neighbor in self.graph[current_node]:
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    zero_in_degree_queue.append(neighbor)

        # Identify nodes that were not visited, indicating presence of cycles
        for node, was_visited in visited.items():
            if not was_visited:
                cycle_nodes.append(node)

        return cycle_nodes

    def find_all_cycles(self):
        """
        Finds all cycles in the directed graph using a depth-first search (DFS).
        
        :return: A list of lists, where each inner list represents a cycle in the graph
        """
        visited = set()
        recursion_stack = []
        cycles = []

        def dfs(node, current_path):
            """
            A recursive helper function that performs DFS to detect cycles.
            
            :param node: The current node in the DFS traversal
            :param current_path: The path traversed so far
            """
            if node in recursion_stack:
                cycle_start_index = recursion_stack.index(node)
                cycles.append(current_path[cycle_start_index:])
                return

            if node in visited:
                return

            visited.add(node)
            recursion_stack.append(node)

            for neighbor in self.graph.get(node, []):
                dfs(neighbor, current_path + [node])

            recursion_stack.remove(node)

        for node in self.graph:
            dfs(node, [])

        return cycles