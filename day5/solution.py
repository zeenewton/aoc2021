with open("input.txt") as f:
    lines = [line.strip() for line in f.readlines()]

coords = []

hit_map = {}
for line in lines:
    line_coords = []
    split_line = line.split(" -> ")
    for block in split_line:
        coords = [int(x) for x in block.split(",")]
        line_coords.append(coords)
    step = 1
    if line_coords[0][0] == line_coords[1][0]:
        start = line_coords[0][1]
        stop = line_coords[1][1]

        if start > stop:
            step = -1
            start -= 1
        else:
            stop += 1
        for i in range(start, stop, step):
            target = f"{line_coords[0][0]},{i}"
            if target in hit_map:
                hit_map[target] += 1
            else:
                hit_map[target] = 1
    elif line_coords[0][1] == line_coords[1][1]:
        start = line_coords[0][0]
        stop = line_coords[1][0]

        if start > stop:
            step = -1
            start -= 1
        else:
            stop += 1
        for i in range(start, stop, step):
            target = f"{i},{line_coords[0][1]}"
            if target in hit_map:
                hit_map[target] += 1
            else:
                hit_map[target] = 1
    else:
        # print("skip")
        pass

print(len([k for k,v in hit_map.items() if v > 1]))
