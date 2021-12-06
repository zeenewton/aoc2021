lines = readlines(ARGS[1])

function mode(mat)
    mode_array = []
    for col in mat
        val_dict = Dict()
        for i in col
            if i in keys(val_dict)
                val_dict[i] += 1
            else
                val_dict[i] = 1
            end
        end
        max_count = nothing
        max_val = nothing
        for i in keys(val_dict)
            if isnothing(max_count)
                max_count = val_dict[i]
                max_val = i
            elseif val_dict[i] > max_count
                max_count = val_dict[i]
                max_val = i
            end
        end
        append!(mode_array, parse(Int, max_val))
    end
    return mode_array
end

function flip_bit(val_array)
    eps_array = []
    for i in val_array
        if i == 0
            append!(eps_array, 1)
        elseif i == 1
            append!(eps_array, 0)
        end
    end
    return eps_array
end

function bin_array_to_int(bin_array)
    output = 0
    for i = length(bin_array):-1:1
        output += bin_array[i] * 2^(length(bin_array) - i)
    end
    return output
end

function string_array_to_int(bin_array)
    output = 0
    for i = length(bin_array):-1:1
        output += parse(Int, bin_array[i]) * 2^(length(bin_array) - i)
    end
    return output
end

function calculate_product(val_array)
    eps_array = flip_bit(val_array)
    gamma = bin_array_to_int(val_array)
    epsilon = bin_array_to_int(eps_array)
    return epsilon * gamma
end


function valmatrix(lines)
    line_length = nothing
    val_matrix = []
    for line in lines
        if isnothing(line_length)
            line_length = length(line)
            for i = 1:line_length
                append!(val_matrix, [[]])
            end
        end
        for i = 1:line_length
            append!(val_matrix[i], line[i])
        end

    end
    return val_matrix
end

function solution1(lines)
    val_matrix = valmatrix(lines)
    return calculate_product(mode(val_matrix))
end



function solution2(lines)
    val_matrix = valmatrix(lines)
    co2_rating = nothing
    o2_rating = nothing
    co2_rows = range(1, length(val_matrix[1]))
    o2_rows = range(1, length(val_matrix[1]))
    for i = 1:12

        count_0 = length([val_matrix[i][j] for j in co2_rows if val_matrix[i][j] == '0'])
        count_1 = length([val_matrix[i][j] for j in co2_rows if val_matrix[i][j] == '1'])
        if count_0 > count_1
            co2_rows = [j for j in co2_rows if val_matrix[i][j] == '1']
        elseif count_1 > count_0
            co2_rows = [j for j in co2_rows if val_matrix[i][j] == '0']
        else
            co2_rows = [j for j in co2_rows if val_matrix[i][j] == '0']
        end
        if length(co2_rows) == 1
            co2_rating = string_array_to_int([col[co2_rows[1]] for col in val_matrix])
        end
    end

    for i = 1:12

        count_0 = length([val_matrix[i][j] for j in o2_rows if val_matrix[i][j] == '0'])
        count_1 = length([val_matrix[i][j] for j in o2_rows if val_matrix[i][j] == '1'])
        if count_0 > count_1
            o2_rows = [j for j in o2_rows if val_matrix[i][j] == '0']
        elseif count_1 > count_0
            o2_rows = [j for j in o2_rows if val_matrix[i][j] == '1']
        else
            o2_rows = [j for j in o2_rows if val_matrix[i][j] == '1']
        end
        if length(o2_rows) == 1
            o2_rating = string_array_to_int([col[o2_rows[1]] for col in val_matrix])
        end
    end
    return o2_rating * co2_rating

end

println(solution1(lines))
println(solution2(lines))