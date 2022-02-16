side = 25;

polyhedron(points = [[0, 0, 0],
                     [side, 0, 0],
                     [side/2, side*sin(60), 0],
                     [side/2, tan(30)*side/2, side*sin(60)]],
           faces = [[0,1,2], [1,2,3], [0,2,3], [0,1,3]]);