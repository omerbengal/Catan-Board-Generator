// Class to represent a hexagon position
class Position {
  final int row;
  final int col;

  Position(this.row, this.col);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position &&
          runtimeType == other.runtimeType &&
          row == other.row &&
          col == other.col;

  @override
  int get hashCode => row.hashCode ^ col.hashCode;
}

class StableShuffle {
  // Helper function to get row length based on row number for regular board
  static int getRowLength(int row) {
    return row <= 2 ? row + 3 : 7 - row;
  }

  // Helper function to get row length for expansion board (7 rows, 30 tiles)
  static int getExpansionRowLength(int row) {
    switch (row) {
      case 0: return 3; // Row 1: 3 tiles (0,1,2)
      case 1: return 4; // Row 2: 4 tiles (3,4,5,6)
      case 2: return 5; // Row 3: 5 tiles (7,8,9,10,11)
      case 3: return 6; // Row 4: 6 tiles (12,13,14,15,16,17) - widest
      case 4: return 5; // Row 5: 5 tiles (18,19,20,21,22)
      case 5: return 4; // Row 6: 4 tiles (23,24,25,26)
      case 6: return 3; // Row 7: 3 tiles (27,28,29)
      default: return 0;
    }
  }

  // Get adjacent hexagon positions for regular board
  static List<Position> _getAdjacentPositions(int row, int col, {bool isExpansion = false}) {
    final positions = <Position>[];

    // Possible adjacent directions for hexagonal grid
    final directions = [
      [-1, -1], [-1, 0], // Top left, Top right
      [0, -1], [0, 1], // Left, Right
      [1, -1], [1, 0], // Bottom left, Bottom right
    ];

    for (final dir in directions) {
      final newRow = row + dir[0];
      final newCol = col + dir[1];

      // Check if position is valid on the board
      final maxRows = isExpansion ? 7 : 5;
      if (newRow >= 0 &&
          newRow < maxRows &&
          newCol >= 0 &&
          newCol < (isExpansion ? getExpansionRowLength(newRow) : getRowLength(newRow))) {
        positions.add(Position(newRow, newCol));
      }
    }

    return positions;
  }

  // Find size of connected group with same resource using DFS
  static int _findConnectedGroup(
    List<List<String>> board,
    int row,
    int col,
    String resource,
    Set<Position> visited,
    {bool isExpansion = false}
  ) {
    final position = Position(row, col);

    // If already visited or different resource, return 0
    if (visited.contains(position) || board[row][col] != resource) {
      return 0;
    }

    visited.add(position);
    var groupSize = 1;

    // Check all adjacent positions
    for (final adj in _getAdjacentPositions(row, col, isExpansion: isExpansion)) {
      groupSize += _findConnectedGroup(
        board,
        adj.row,
        adj.col,
        resource,
        visited,
        isExpansion: isExpansion
      );
    }

    return groupSize;
  }

  // Convert 1D array to 2D board representation for regular board
  static List<List<String>> _create2DBoard(List<String> resources, {bool isExpansion = false}) {
    final maxRows = isExpansion ? 7 : 5;
    final board = List<List<String>>.generate(
      maxRows,
      (row) => List<String>.filled(
        isExpansion ? getExpansionRowLength(row) : getRowLength(row), 
        ''
      ),
    );

    var index = 0;
    for (var row = 0; row < maxRows; row++) {
      final rowLength = isExpansion ? getExpansionRowLength(row) : getRowLength(row);
      for (var col = 0; col < rowLength; col++) {
        board[row][col] = resources[index];
        index++;
      }
    }

    return board;
  }

  // Check if Catan board is valid (no groups of 3+ same resources)
  static bool isCatanBoardValid(List<String> boardResources, {bool isExpansion = false}) {
    // Convert 1D array to 2D board representation
    final board = _create2DBoard(boardResources, isExpansion: isExpansion);
    final maxRows = isExpansion ? 7 : 5;

    // Check each position on the board
    for (int row = 0; row < maxRows; row++) {
      final rowLength = isExpansion ? getExpansionRowLength(row) : getRowLength(row);
      for (int col = 0; col < rowLength; col++) {
        final resource = board[row][col];
        if (resource != 'Desert') {
          // Get all connected hexagons with same resource
          final visited = <Position>{};
          final groupSize = _findConnectedGroup(
            board,
            row,
            col,
            resource,
            visited,
            isExpansion: isExpansion
          );

          // If group size is 3 or more, board is invalid
          if (groupSize >= 3) {
            return false;
          }
        }
      }
    }

    return true;
  }

  // Check if number layout is valid (no adjacent 6s and 8s)
  static bool isCatanNumbersValid(List<String> boardNumbers, {bool isExpansion = false}) {
    // Define adjacent indices for each position (0-based)
    late final Map<int, List<int>> adjacencyMap;
    
    if (isExpansion) {
      // Expansion board adjacency (30 tiles, 7 rows: 3-4-5-6-5-4-3)
      adjacencyMap = {
        // Row 1 (3 tiles: 0,1,2)
        0: [1, 3, 4],
        1: [0, 2, 4, 5],
        2: [1, 5, 6],
        
        // Row 2 (4 tiles: 3,4,5,6)  
        3: [0, 4, 7, 8],
        4: [0, 1, 3, 5, 8, 9],
        5: [1, 2, 4, 6, 9, 10],
        6: [2, 5, 10, 11],
        
        // Row 3 (5 tiles: 7,8,9,10,11)
        7: [3, 8, 12, 13],
        8: [3, 4, 7, 9, 13, 14],
        9: [4, 5, 8, 10, 14, 15],
        10: [5, 6, 9, 11, 15, 16],
        11: [6, 10, 16, 17],
        
        // Row 4 (6 tiles: 12,13,14,15,16,17) - widest row
        12: [7, 13, 18, 19],
        13: [7, 8, 12, 14, 18, 19, 20],
        14: [8, 9, 13, 15, 19, 20, 21],
        15: [9, 10, 14, 16, 20, 21, 22],
        16: [10, 11, 15, 17, 21, 22],
        17: [11, 16, 22],
        
        // Row 5 (5 tiles: 18,19,20,21,22)
        18: [12, 13, 19, 23, 24],
        19: [12, 13, 14, 18, 20, 23, 24, 25],
        20: [13, 14, 15, 19, 21, 24, 25, 26],
        21: [14, 15, 16, 20, 22, 25, 26],
        22: [15, 16, 17, 21, 26],
        
        // Row 6 (4 tiles: 23,24,25,26)
        23: [18, 19, 24, 27, 28],
        24: [18, 19, 20, 23, 25, 28, 29],
        25: [19, 20, 21, 24, 26, 29],
        26: [20, 21, 22, 25],
        
        // Row 7 (3 tiles: 27,28,29)
        27: [23, 28],
        28: [23, 24, 27, 29],
        29: [24, 25, 28],
      };
    } else {
      // Regular board adjacency (19 tiles)
      adjacencyMap = {
        // Top row (indices 0-2)
        0: [1, 3, 4],
        1: [0, 2, 4, 5],
        2: [1, 5, 6],
        
        // Second row (indices 3-6)
        3: [0, 4, 7, 8],
        4: [0, 1, 3, 5, 8, 9],
        5: [1, 2, 4, 6, 9, 10],
        6: [2, 5, 10, 11],
        
        // Middle row (indices 7-11)
        7: [3, 8, 12],
        8: [3, 4, 7, 9, 12, 13],
        9: [4, 5, 8, 10, 13, 14],
        10: [5, 6, 9, 11, 14, 15],
        11: [6, 10, 15],
        
        // Fourth row (indices 12-15)
        12: [7, 8, 13, 16],
        13: [8, 9, 12, 14, 16, 17],
        14: [9, 10, 13, 15, 17, 18],
        15: [10, 11, 14, 18],
        
        // Bottom row (indices 16-18)
        16: [12, 13, 17],
        17: [13, 14, 16, 18],
        18: [14, 15, 17],
      };
    }
    
    // Check each position for 6s and 8s
    for (int i = 0; i < boardNumbers.length; i++) {
      if (boardNumbers[i] == '6' || boardNumbers[i] == '8') {
        // Check all adjacent positions
        final neighbors = adjacencyMap[i];
        if (neighbors != null) {
          for (int adjIndex in neighbors) {
            if (adjIndex < boardNumbers.length &&
                (boardNumbers[adjIndex] == '6' || boardNumbers[adjIndex] == '8')) {
              return false;
            }
          }
        }
      }
    }
    
    return true;
  }

  // Generate stable board resources
  static List<String> generateStableBoard({bool isExpansion = false}) {
    List<String> boardResources;
    
    if (isExpansion) {
      boardResources = [
        'Wood', 'Wood', 'Wood', 'Wood', 'Wood', 'Wood',
        'Tit', 'Tit', 'Tit', 'Tit', 'Tit',
        'Ore', 'Ore', 'Ore', 'Ore', 'Ore',
        'Wheat', 'Wheat', 'Wheat', 'Wheat', 'Wheat', 'Wheat',
        'Sheep', 'Sheep', 'Sheep', 'Sheep', 'Sheep', 'Sheep',
        'Desert', 'Desert'
      ];
    } else {
      boardResources = [
        'Wood', 'Wood', 'Wood', 'Wood',
        'Tit', 'Tit', 'Tit',
        'Ore', 'Ore', 'Ore',
        'Wheat', 'Wheat', 'Wheat', 'Wheat',
        'Sheep', 'Sheep', 'Sheep', 'Sheep',
        'Desert'
      ];
    }
    
    bool isValid = false;
    int attempts = 0;
    const maxAttempts = 1000; // Prevent infinite loops
    
    while (!isValid && attempts < maxAttempts) {
      boardResources.shuffle();
      isValid = isCatanBoardValid(boardResources, isExpansion: isExpansion);
      attempts++;
    }
    
    return boardResources;
  }

  // Generate stable number layout
  static List<String> generateStableNumbers(List<String> boardResources, {bool isExpansion = false}) {
    List<String> boardNumbers;
    
    if (isExpansion) {
      boardNumbers = [
        '2', '2', '3', '3', '3', '4', '4', '4',
        '5', '5', '5', '6', '6', '6',
        '8', '8', '8', '9', '9', '9',
        '10', '10', '10', '11', '11', '11',
        '12', '12', 'd', 'd'
      ];
    } else {
      boardNumbers = [
        '2', '3', '3', '4', '4', '5', '5',
        '6', '6', '8', '8', '9', '9',
        '10', '10', '11', '11', '12', 'd'
      ];
    }
    
    bool isValid = false;
    int attempts = 0;
    const maxAttempts = 1000; // Prevent infinite loops
    
    while (!isValid && attempts < maxAttempts) {
      // Generate random board
      boardNumbers.shuffle();
      
      // Set 'd' to appropriate desert locations
      if (isExpansion) {
        int desertIndex1 = boardResources.indexOf('Desert');
        int desertIndex2 = boardResources.lastIndexOf('Desert');
        
        // Create temp list without 'd' markers
        List<String> tempNumbers = List.from(boardNumbers)
          ..removeWhere((number) => number == 'd');
        
        tempNumbers.shuffle();
        
        // Create final list with 'd' at desert positions
        List<String> finalNumbers = List.filled(boardNumbers.length, '');
        finalNumbers[desertIndex1] = 'd';
        finalNumbers[desertIndex2] = 'd';
        
        // Fill remaining positions
        int tempIndex = 0;
        for (int i = 0; i < finalNumbers.length; i++) {
          if (finalNumbers[i] == '') {
            finalNumbers[i] = tempNumbers[tempIndex];
            tempIndex++;
          }
        }
        
        boardNumbers = finalNumbers;
      } else {
        // Regular board - single desert
        var desertIndex = boardResources.indexOf('Desert');
        boardNumbers[boardNumbers.indexOf('d')] = boardNumbers[desertIndex];
        boardNumbers[desertIndex] = 'd';
      }
      
      // Check if the numbers' layout is valid
      isValid = isCatanNumbersValid(boardNumbers, isExpansion: isExpansion);
      attempts++;
    }
    
    return boardNumbers;
  }
}