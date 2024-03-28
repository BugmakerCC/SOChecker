from collections import defaultdict
from collections import deque

class Graph:
    
    def __init__(self):
        self.graph = defaultdict(list)

    def add_edge(self, u, v):
        self.graph[u].append(v)
        
    def detect_cycle_with_topological_sort(self,allNodes):
        
        in_degree = {node: 0 for node in allNodes}
        for node in self.graph:
            for neighbor in self.graph[node]:
                if neighbor in in_degree:
                    in_degree[neighbor] += 1


        visited = {node:False for node in allNodes}

        circleNode = []

       
        queue = deque([node for node in in_degree if in_degree[node] == 0])

        while queue:
            node = queue.popleft()
            visited[node] = True
            for neighbor in self.graph[node]:
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        for key, value in visited.items():
            if not value:
                circleNode.append(key)


        return circleNode
    
    def find_cycles(self):
        
        visited = set()
        rec_stack = []  
        cycles = []  
        def dfs(node, cycle):
            if node in rec_stack:
                cycle.append(node)
                cycles.append(cycle[rec_stack.index(node):])
                return

            if node in visited:
                return

            visited.add(node)
            rec_stack.append(node)  

            for neighbor in self.graph.get(node, []):
                dfs(neighbor, cycle + [node])

            rec_stack.remove(node)  
        for node in self.graph:
            dfs(node, [])

        return cycles
