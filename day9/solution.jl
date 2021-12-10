lines = readlines(ARGS[1])


function solution1(lines)
    val_matrix = []
    for line in lines
        line_vals = [parse(Int, v) for v in line]
        append!(val_matrix, [line_vals])
    end
    num_rows = length(val_matrix)
    row_width = length(val_matrix[1])
    minima = []
    for (i, row) in enumerate(val_matrix)
        for (j, val) in enumerate(row)
            is_minimal = true
            # check above
            if i > 1
                if val >= val_matrix[i-1][j]
                    is_minimal = false
                end
            end
            # check below
            if i < num_rows
                if val >= val_matrix[i+1][j]
                    is_minimal = false
                end
            end
            # check left 
            if j > 1
                if val >= val_matrix[i][j-1]
                    is_minimal = false
                end
            end
            # check right
            if j < row_width
                if val >= val_matrix[i][j+1]
                    is_minimal = false
                end
            end
            if is_minimal
                append!(minima, val + 1)
            end
        end
    end
    return sum(minima)
end



function crawl_basin(basin, val_matrix, num_rows, row_width)
    to_search = Set(basin)
    found = Set(basin)
    while length(to_search) > 0
        check_point = pop!(to_search)
        check_x = check_point[1]
        check_y = check_point[2]
        # check above
        if check_y - 1 >= 1 && val_matrix[check_x][check_y-1] != 9 && !in([check_x, check_y - 1], found)
            push!(to_search, [check_x, check_y - 1])
            push!(found, [check_x, check_y - 1])
        end
        # check below
        if check_y + 1 <= num_rows && val_matrix[check_x][check_y+1] != 9 && !in([check_x, check_y + 1], found)
            push!(to_search, [check_x, check_y + 1])
            push!(found, [check_x, check_y + 1])
        end
        # check left
        if check_x - 1 >= 1 && val_matrix[check_x-1][check_y] != 9 && !in([check_x - 1, check_y], found)
            push!(to_search, [check_x - 1, check_y])
            push!(found, [check_x - 1, check_y])
        end
        # check right
        if check_x + 1 <= row_width && val_matrix[check_x+1][check_y] != 9 && !in([check_x + 1, check_y], found)
            push!(to_search, [check_x + 1, check_y])
            push!(found, [check_x + 1, check_y])
        end
    end
    return [x for x in found]
end

function solution2(lines)
    val_matrix = []
    for line in lines
        line_vals = [parse(Int, v) for v in line]
        append!(val_matrix, [line_vals])
    end
    num_rows = length(val_matrix)
    row_width = length(val_matrix[1])
    minima = []
    basins = []
    for (i, row) in enumerate(val_matrix)
        for (j, val) in enumerate(row)
            is_minimal = true
            basin = [[i, j]]
            # check above
            if i > 1
                if val >= val_matrix[i-1][j]
                    is_minimal = false
                else
                    if val_matrix[i-1][j] != 9
                        append!(basin, [[i - 1, j]])
                    end

                end
            end
            # check below
            if i < num_rows
                if val >= val_matrix[i+1][j]
                    is_minimal = false
                else
                    if val_matrix[i+1][j] != 9
                        append!(basin, [[i + 1, j]])
                    end
                end
            end
            # check left 
            if j > 1
                if val >= val_matrix[i][j-1]
                    is_minimal = false
                else
                    if val_matrix[i][j-1] != 9
                        append!(basin, [[i, j - 1]])
                    end
                end
            end
            # check right
            if j < row_width
                if val >= val_matrix[i][j+1]
                    is_minimal = false
                else
                    if val_matrix[i][j+1] != 9
                        append!(basin, [[i, j + 1]])
                    end
                end
            end
            if is_minimal
                append!(minima, val + 1)
                append!(basins, [basin])
            end
        end
    end

    crawled_basins = []
    for basin in basins
        append!(crawled_basins, length(crawl_basin(basin, val_matrix, num_rows, row_width)))
    end

    rev_lengths = reverse(sort(crawled_basins))

    return rev_lengths[1] * rev_lengths[2] * rev_lengths[3]
end

println(solution1(lines))

println(solution2(lines))