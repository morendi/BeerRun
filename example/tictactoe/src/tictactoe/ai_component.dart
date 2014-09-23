part of tictactoe;

//import 'dart:async';
//import 'entities.dart';

class AIComponent extends PlayerComponent {

    void _gameStarted() {

    }

    Future<Position> _pickMove(Player player, Board board) {

        return new Future<Position>.delayed(new Duration(), () {
            final int rows = board.rows;
            final int cols = board.cols;

            // take the center spot if it is available
            if (board._board[rows ~/ 2][cols ~/ 2] == null) {
                return new Position(rows ~/ 2, cols ~/ 2);
            }

            for (int row = 0 ; row < rows; ++row) {
                for (int col = 0; col < cols; ++col) {
                    if (board._board[row][col] == null) {
                        return new Position(row, col);
                    }
                }
            }

            throw new Exception("No available spots");
        });
    }
}
