lines = readlines(ARGS[1])


function check_boards(check_val, boards)
    for (i, o) in enumerate(boards) 
        if board_wins(check_val, boards[i][1], boards[i][2])
            return boards[i][1], boards[i][2]
        else
            continue
        end
    end

    return nothing, nothing
end

function board_wins(check_val, check_board, result_board)
    for (row_i, row_v) in enumerate(check_board)
        for (col_i, col_v) in enumerate(row_v)
            if col_v == check_val
                result_board[row_i][col_i] = check_val
                break
            end
        end
    end
    if check_rows(result_board)
        return true
    elseif check_columns(result_board)
        return true
    else
        return false
    end
end

function check_columns(result_board)
    for (i, v) in enumerate(result_board[1])
        if !isnothing(v)
            if size([row[i] for row in result_board if row[i] != ""]) == (5,)
                return true
            end
        end
    end
    return false
end

function check_rows(result_board)
    for row in result_board
        if size([x for x in row if x != ""]) == (5,)
            return true
        end
    end
    return false
end






function solution1(lines)
    moves = nothing
    boards = []
    board = []
    for (iter_val, line) in enumerate(lines)
        if iter_val == 1
            moves = split(line, ",")
        elseif iter_val > 2
            if line == ""
                append!(boards, [(board, [["" for i in 1:5] for i in 1:5])])
                board = []
            else
                append!(board, [split(line)])
            end
        else
            continue
        end
    end

    (win_board, win_positions) = (nothing, nothing)
    skip = Int[]
    for move in moves
        for (i, o) in enumerate(boards) 
            if i in skip
                continue
            end
            for (row_i, row_v) in enumerate(boards[i][1])
                for (col_i, col_v) in enumerate(row_v)
                    if col_v == move
                        boards[i][2][row_i][col_i] = move
                        break
                        break
                    end
                end
            end
            if check_rows(boards[i][2])
                (win_board, win_positions) = boards[i]
                append!(skip, i)
            elseif check_columns(boards[i][2])
                (win_board, win_positions) = boards[i]
                append!(skip, i)
            end
        end
        
        if isnothing(win_board)
            continue
        else
            sum_val = 0
            for (row_i, row_v) in enumerate(win_positions)
                for (col_i, col_v) in enumerate(row_v)
                    if col_v == ""
                        sum_val += parse(Int, win_board[row_i][col_i])
                    end
                end
            end
            println(sum_val*parse(Int, move))
            
        end
        (win_board, win_positions) = (nothing, nothing)


    end
    # moves = parse_moves(lines[1])
    # lines = Array(lines)
    # println(lines[3:size(lines)])

    
    # boards = parse_games(lines[3:-1])
    return nothing
end

# function solution2(lines)

# end

solution1(lines)