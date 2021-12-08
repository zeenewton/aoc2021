lines = readlines(ARGS[1])


function solution1(lines)
    total = 0
    for line in lines
        output = split(split(line, "|")[2])
        total += length([x for x in output if length(x) in [2, 3, 4, 7]])
    end
    return total
end

# T = Top
# UR = Upper Right
# LR = Lower Right
# M = Middle
# B = Bottom
# UL = Upper left
# LL = Lower Left

# 0 - T, UL, UR, LL, LR, B - count=6
# 1 - UR, LR - count=2
# 2 - T, M, B, UR, LL - count=5
# 3 - T, M, B, UR, LR - count=5
# 4 - M, UR, UL, LR - count=4
# 5 - T, M, B, UL, LR - count=5
# 6 - T, M, B, UL, LL, LR - count=6
# 7 - T, UR, LR - count=3
# 8 - T, M, B, UR, LR, UL, LL - count=7
# 9 - T, M, B, UR, LR, UL  - count=6
render_dict = Dict()
render_dict[Set(["T", "UL", "UR", "LL", "LR", "B"])] = 0
render_dict[Set(["UR", "LR"])] = 1
render_dict[Set(["T", "M", "B", "UR", "LL"])] = 2
render_dict[Set(["T", "M", "B", "UR", "LR"])] = 3
render_dict[Set(["M", "UR", "UL", "LR"])] = 4
render_dict[Set(["T", "M", "B", "UL", "LR"])] = 5
render_dict[Set(["T", "M", "B", "UL", "LL", "LR"])] = 6
render_dict[Set(["T", "UR", "LR"])] = 7
render_dict[Set(["T", "M", "B", "UR", "LR", "UL", "LL"])] = 8
render_dict[Set(["T", "M", "B", "UR", "LR", "UL"])] = 9

# T = set(size=3) - set(size=2)
# UR = count(8) from set(size=2)
# LR = count(9) from set(size=2)
# M = count(7) from set(size=4) - UR,LR
# UL = remaining from set(size=4) - UR,LR,M
# B = remaining from set(size=5) that contains T,M,UL,LR
# LL = remaining

function get_top(groups)
    group_size_3 = [g for g in groups if length(g) == 3][1]
    group_size_2 = [g for g in groups if length(g) == 2][1]
    return [char for char in setdiff(group_size_3, group_size_2)][1]
end


function get_upper_right(groups)
    group_size_2 = [g for g in groups if length(g) == 2][1]
    counts = Dict()
    for char in group_size_2
        count = 0
        for group in groups
            if in(char, group)
                count += 1
            end
        end
        counts[count] = char
    end
    return counts[8], counts[9]
end

function get_middle(groups)
    group_size_4 = [g for g in groups if length(g) == 4][1]
    group_size_2 = [g for g in groups if length(g) == 2][1]
    diff_group = setdiff(group_size_4, group_size_2)
    counts = Dict()
    for char in diff_group
        count = 0
        for group in groups
            if in(char, group)
                count += 1
            end
        end
        counts[count] = char
    end
    return counts[7]

end

function get_upper_left(groups, loc_map)
    group_size_4 = [g for g in groups if length(g) == 4][1]
    return [x for x in setdiff(group_size_4, Set([loc_map["UR"], loc_map["LR"], loc_map["M"]]))][1]
end



function get_bottom(groups, loc_map)
    # B = remaining from set(size=5) that contains T,M,UL,LR
    size_5_groups = [g for g in groups if length(g) == 5]

    for s5group in size_5_groups
        diff = setdiff(s5group, Set([loc_map["T"], loc_map["M"], loc_map["UL"], loc_map["LR"]]))
        if length(diff) == 1
            if in(loc_map["T"], s5group) && in(loc_map["M"], s5group) && in(loc_map["UL"], s5group) && in(loc_map["LR"], s5group)
                return [d for d in diff][1]
            end

        end
    end
end

function get_lower_left(groups, loc_map)
    group_size_7 = [g for g in groups if length(g) == 7][1]
    return [x for x in setdiff(group_size_7, Set([
        loc_map["T"], loc_map["M"], loc_map["UL"], loc_map["LR"], loc_map["UR"], loc_map["B"]
    ]))][1]
end

function decode_input(input)
    loc_map = Dict()
    groups = [Set(x) for x in input]
    loc_map["T"] = get_top(groups)
    (loc_map["UR"], loc_map["LR"]) = get_upper_right(groups)
    loc_map["M"] = get_middle(groups)
    loc_map["UL"] = get_upper_left(groups, loc_map)
    loc_map["B"] = get_bottom(groups, loc_map)
    loc_map["LL"] = get_lower_left(groups, loc_map)
    reverse_map = Dict()
    for key in keys(loc_map)
        reverse_map[loc_map[key]] = key
    end
    return reverse_map
end

function render_output(output, decode_map)
    groups = [Set(x) for x in output]
    total = 0
    for (i, group) in enumerate(groups)
        decoded_set = Set([decode_map[x] for x in group])
        total += render_dict[decoded_set] * 10^(4 - i)
    end
    return total
end


function solution2(lines)
    total = 0
    for line in lines
        input = split(split(line, "|")[1])
        output = split(split(line, "|")[2])
        decoded = decode_input(input)
        total += render_output(output, decoded)
        # break
    end
    return total
end

println(solution1(lines))

println(solution2(lines))