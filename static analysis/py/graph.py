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
    