/***************************************/
/* 15 puzzle solver                    */
/*                                     */
/* 2015-04-22                          */
/* Leonardone @ NEETSDKASU             */
/***************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <limits.h>

#define X_SIZE (4)
#define Y_SIZE (4)
#define MAX_NUMBER (X_SIZE * Y_SIZE - 1)
#define TABLE_X_SIZE (X_SIZE + 2)
#define TABLE_Y_SIZE (Y_SIZE + 2)
#define SPACE   (0)
#define FIXED  (-1)
#define UNFIXED (0)

#define MOVE_LEFT  (1)
#define MOVE_RIGHT (2)
#define MOVE_UP    (3)
#define MOVE_DOWN  (4)


#ifdef DEBUG_MODE
# define dcode(s) s
# define dputs(s) puts(s)
#else
# define dcode(s)
# define dputs(s) 
#endif

typedef struct _Position {
	int x;
	int y;
} Position;

typedef int Table[TABLE_Y_SIZE][TABLE_X_SIZE];

typedef struct _Puzzle {
	Table table;
	Position space;
	int count;
	int show;
	int lastmove;
	int lastmovecount;
} Puzzle;

typedef void (*PuzzleCreater)(Puzzle *);

int iAbs(const int value);
void printBar(void);
void printTable(char const *name, const Table table);
void printPuzzle(Puzzle const *puzzle);
void makePuzzle(Puzzle *puzzle);
void inputPuzzle(Puzzle *puzzle);
void moveOneSpace(Puzzle *puzzle, const int dx, const int dy);
void moveUpSpace(Puzzle *puzzle);
void moveDownSpace(Puzzle *puzzle);
void moveLeftSpace(Puzzle *puzzle);
void moveRightSpace(Puzzle *puzzle);
void fillTable(Table table, const int value);
void fillTableRow(Table table, const int row, const int value);
void fillTabelColumn(Table table, const int column, const int value);
Position number2postion(const int number);
Position makePosition(const int x, const int y);
Position *setPosition(Position *position, const int x, const int y);
int distance(const Position pos1, const Position pos2);
void seekNextRoot(Table rootmap, Table costmap, Table minusmap, Table plusmap, Table nextmap, int x, int y, int c, int mc, int pc, int d, int next_f, Position tp, int mv);
int searchSpaceRoot(Puzzle *puzzle, const Table fixes, Table nextmap, const Position pos);
void moveSpace(Puzzle *puzzle, const Table nextmap, const Position pos);
Position searchNumber(Puzzle const *puzzle, const int number);
int searchRoot(const Table fixes, Table rootmap, const Position posFrom, const Position posTo);
int moveNumber(Puzzle *puzzle, Table fixes, const int number, const Position pos1);
void moveRight2Numbers(Puzzle *puzzle, Table fixes, const int x, const int y, int n);
void setSamplePuzzle(Puzzle *puzzle);
void moveLeft2Numbers(Puzzle *puzzle, Table fixes, const int x, const int y, int n);
int solve(Puzzle *puzzle, Table fixes);
void tryit(Puzzle *puzzle, PuzzleCreater pcreator, int showpuzzle, int showroot);
void calcAverage(Puzzle *puzzle, int count);

int main(void) {
	Puzzle puzzleData;
	
	srand((unsigned)time(NULL));
	
	tryit(&puzzleData, inputPuzzle, 0, 1);
	
	/* calcAverage(&puzzleData, 1000); */
	
	return 0;
}

void setSamplePuzzle(Puzzle *puzzle) {
	Table table = {
		{ -1, -1, -1, -1, -1, -1},
		{ -1,  1,  2,  5,  8, -1},
		{ -1, 11,  6,  3,  0, -1},
		{ -1,  7, 12,  9, 10, -1},
		{ -1, 15, 13,  4, 14, -1},
		{ -1, -1, -1, -1, -1, -1}
	};
	int i, j;
	for (i = 0; i < TABLE_Y_SIZE; i++) {
		for (j = 0; j < TABLE_X_SIZE; j++) {
			if (table[i][j] == 0) {
				puzzle->space.x = j;
				puzzle->space.y = i;
			}
			puzzle->table[i][j] = table[i][j];
		}
	}
}

void inputPuzzle(Puzzle *puzzle) {
	int i, j, n;
	char str[10];
	for (i = 1; i <= Y_SIZE; i++) {
		for (j = 1; j <= X_SIZE; j++) {
			scanf("%s", str);
			if (isdigit(str[0])) {
				n = atoi(str);
			} else {
				n = 0;
			}
			if (n == 0) {
				puzzle->space.x = j;
				puzzle->space.y = i;
			}
			puzzle->table[i][j] = n;
		}
	}
}

void tryit(Puzzle *puzzle, PuzzleCreater create, int showpuzzle, int showroot) {
	Table fixes;
	
	puzzle->lastmove = 0;
	puzzle->lastmovecount = 0;
	
	fillTable(fixes, UNFIXED);
	fillTableRow(fixes, 0, FIXED);
	fillTableRow(fixes, TABLE_Y_SIZE - 1, FIXED);
	fillTabelColumn(fixes, 0, FIXED);
	fillTabelColumn(fixes, TABLE_X_SIZE - 1, FIXED);
	
	puzzle->show = 0;
	create(puzzle);
	
	if (showpuzzle != 0) {
		printPuzzle(puzzle);
	}
	
	puzzle->count = 0;
	puzzle->show = showroot;
	
	solve(puzzle, fixes);
	
	if (showpuzzle != 0) {
		printBar();
		printPuzzle(puzzle);
		printf("count: %d\n", puzzle->count);
	}
}

void calcAverage(Puzzle *puzzle, int count) {
	int i, t = 0;

	for (i = 0; i < count; i++) {
		tryit(puzzle, makePuzzle, 0, 0);
		t += puzzle->count;
	}
	
	printf("average %d\n", (t + 5 * i / 10) / i);
}

int solve(Puzzle *puzzle, Table fixes) {
	Table nextmap;
	Position pos;
	int i, j, m, n = 1;
	for (i = 1; i <= Y_SIZE - 2; i++, n++) {
		dcode(printf("i=%d\n", i));
		for (j = 1; j <= X_SIZE - 2; j++, n++) {
			pos = number2postion(n);
			if (moveNumber(puzzle, fixes, n, pos) < 0) {
				printPuzzle(puzzle);
				printf("error j=%d\n", n);
				return -1;
			}
			fixes[pos.y][pos.x] = FIXED;
		}
		moveRight2Numbers(puzzle, fixes, j, i, n++);
	}
	for (j = 1; j <= X_SIZE - 2; j++, n++) {
		moveLeft2Numbers(puzzle, fixes, j, i, n);
	}
	moveNumber(puzzle, fixes, n, number2postion(n));
	n++;
	moveNumber(puzzle, fixes, n, number2postion(n));
	pos = makePosition(X_SIZE, Y_SIZE);
	searchSpaceRoot(puzzle, fixes, nextmap, pos);
	moveSpace(puzzle, nextmap, pos);
	return 0;
}

int iAbs(const int value) {
	if (value < 0) {
		return -value;
	} else {
		return value;
	}
}

void printBar(void) {
	puts("***************************");
}


void printTable(char const *name, const Table table) {
	int x, y;
	printBar();
	puts(name);
	for (y = 0; y < TABLE_Y_SIZE; y++) {
		for (x = 0; x < TABLE_X_SIZE; x++) {
			if (x > 0) {
				putchar(' ');
			}
			printf("%+2d", table[y][x]);
		}
		putchar('\n');
	}
}

void printPuzzle(Puzzle const *puzzle) {
	int i, j;
	for (i = 1; i <= Y_SIZE; i++) {
		for (j = 1; j <= X_SIZE; j++) {
			if (j > 0) {
				putchar(' ');
			}
			if (puzzle->table[i][j] > 0) {
				printf("%2d", puzzle->table[i][j]);
			} else {
				printf(" *");
			}
		}
		putchar('\n');
	}
}

void makePuzzle(Puzzle *puzzle) {
	/* init */
	{
		int i, j, n = 1;
		for (i = 1; i <= Y_SIZE; i++) {
			for (j = 1; j <= X_SIZE; j++) {
				puzzle->table[i][j] = n++;
			}
		}
		puzzle->space.x = X_SIZE;
		puzzle->space.y = Y_SIZE;
		puzzle->table[puzzle->space.y][puzzle->space.x] = SPACE;
	}
	/* shuffle */
	{
		int s, k = 0;
		for (s = 0; s < 1000; s++) {
			if (k == 0) {
				int p = (rand() % (X_SIZE - 1)) + 1;
				if (puzzle->space.x == p) {
					p++;
				}
				if (puzzle->space.x < p) {
					do {
						moveRightSpace(puzzle);
					} while (puzzle->space.x < p);
				} else {
					do {
						moveLeftSpace(puzzle);
					} while (puzzle->space.x > p);
				}
			} else {
				int p = (rand() % (Y_SIZE - 1)) + 1;
				if (puzzle->space.y == p) {
					p++;
				}
				if (puzzle->space.y < p) {
					do {
						moveDownSpace(puzzle);
					} while (puzzle->space.y < p);
				} else {
					do {
						moveUpSpace(puzzle);
					} while (puzzle->space.y > p);
				}
			}
			k = !k;
		}
	}
}

void moveOneSpace(Puzzle *puzzle, const int dx, const int dy) {
	int x = (puzzle->space.x += dx);
	int y = (puzzle->space.y += dy);
	int n = (puzzle->table[y - dy][x - dx] = puzzle->table[y][x]);
	puzzle->table[y][x] = 0;
	puzzle->count++;
	if (puzzle->show != 0) {
		dcode(printBar());
		printf("%d\n", n);
		dcode(printPuzzle(puzzle));
		if (puzzle->lastmovecount > 4) {
			printf("lastmove error %d\n", n);
			printPuzzle(puzzle);
			exit(EXIT_SUCCESS);
		}
		if (puzzle->lastmove == n) {
			puzzle->lastmovecount++;
		} else {
			puzzle->lastmovecount = 0;
			puzzle->lastmove = n;
		}
	}
}

void moveUpSpace(Puzzle *puzzle) {
	if (puzzle->space.y <= 1) {
		printf("moveUp error");
		exit(EXIT_SUCCESS);
	}
	moveOneSpace(puzzle, 0, -1);
}

void moveDownSpace(Puzzle *puzzle) {
	if (puzzle->space.y >= Y_SIZE) {
		printf("moveDown error");
		exit(EXIT_SUCCESS);
	}
	moveOneSpace(puzzle, 0, 1);
}

void moveLeftSpace(Puzzle *puzzle) {
	if (puzzle->space.x <= 1) {
		printf("moveLeft error");
		exit(EXIT_SUCCESS);
	}
	moveOneSpace(puzzle, -1, 0);
}

void moveRightSpace(Puzzle *puzzle) {
	if (puzzle->space.x >= X_SIZE) {
		printf("moveRight error");
		exit(EXIT_SUCCESS);
	}
	moveOneSpace(puzzle, 1, 0);
}

void fillTable(Table table, const int value) {
	int i, j;
	for (i = 0; i < TABLE_Y_SIZE; i++) {
		for (j = 0; j < TABLE_X_SIZE; j++) {
			table[i][j] = value;
		}
	}
}

void fillTableRow(Table table, const int row, const int value) {
	int j;
	for (j = 0; j < TABLE_X_SIZE; j++) {
		table[row][j] = value;
	}
}

void fillTabelColumn(Table table, const int column, const int value) {
	int i;
	for (i = 0; i < TABLE_Y_SIZE; i++) {
		table[i][column] = value;
	}
}

Position number2postion(const int number) {
	Position position;
	position.x = ((number - 1) % X_SIZE) + 1;
	position.y = ((number - 1) / X_SIZE) + 1;
	return position;
}

Position makePosition(const int x, const int y) {
	Position position;
	position.x = x;
	position.y = y;
	return position;
}

Position *setPosition(Position *position, const int x, const int y) {
	position->x = x;
	position->y = y;
	return position;
}

int distance(const Position pos1, const Position pos2) {
	return iAbs(pos2.x - pos1.x) + iAbs(pos2.y - pos1.y);
}

void setStartRoot(Table rootmap, Table costmap, Table minusmap, Table plusmap, Table nextmap, int x, int y, int d, int f, Position tp, int mv) {
	int c;
	if (rootmap[y][x] == 0) {
		rootmap[y][x] = f;
		costmap[y][x] = c = distance(tp, makePosition(x, y)) - d;
		minusmap[y][x] = c < 0 ? c : 0;
		plusmap[y][x] = c > 0 ? c : 0;
		nextmap[y][x] = mv;
	}
}

void seekNextRoot(Table rootmap, Table costmap, Table minusmap, Table plusmap, Table nextmap, int x, int y, int c, int mc, int pc, int d, int next_f, Position tp, int mv) {
	int c2, mc2, pc2;
	if (rootmap[y][x] == 0) {
		rootmap[y][x] = next_f;
		costmap[y][x] = c + (c2 = distance(tp, makePosition(x, y)) - d);
		minusmap[y][x] = mc + (c2 < 0 ? c2 : 0);
		plusmap[y][x] = pc + (c2 > 0 ? c2 : 0);
		nextmap[y][x] = mv;
	} else if (rootmap[y][x] == next_f) {
		c += c2 = distance(tp, makePosition(x, y)) - d;
		mc2 = mc + (c2 < 0 ? c2 : 0);
		pc2 = pc + (c2 > 0 ? c2 : 0);
		if (c < costmap[y][x - 1]
				|| (c2 == costmap[y][x] && (pc2 < plusmap[y][x]
					|| (pc2 == plusmap[y][x] && mc2 < minusmap[y][x])))) {
			costmap[y][x] = c;
			minusmap[y][x] = mc2;
			plusmap[y][x] = pc2;
			nextmap[y][x] = mv;
		}
	}
}


int searchSpaceRoot(Puzzle *puzzle, const Table fixes, Table nextmap, const Position pos) {
	/* if (fixes[pos.y][pos.x] == FIXED) { perror("cannot move"); return; } */
	/* Table rootmap, costmap = {{0}}, nextmap = {{0}}, minusmap = {{0}}, plusmap = {{0}}; */
	Table rootmap, costmap, minusmap, plusmap;
	nextmap[pos.y][pos.x] = 0;
	if (puzzle->space.x == pos.x && puzzle->space.y == pos.y) {
		return INT_MIN;
	}
	/* init maps */
	{
		int x, y;
		for (y = 0; y < TABLE_Y_SIZE; y++) {
			for (x = 0; x < TABLE_X_SIZE; x++) {
				if (fixes[y][x] == FIXED) {
					rootmap[y][x] = -1;
				} else {
					rootmap[y][x] = 0;
				}
				nextmap[y][x] = 0;
			}
		}
	}
	/* seek pos from space pos */
	{
		/* set start position */
		int f = 1;
		int x = pos.x;
		int y = pos.y;
		Position tp  = number2postion(puzzle->table[y][x]);
		int d = distance(tp, makePosition(x, y));
		if (rootmap[y][x] != 0) {
			dputs("error in searchSpaceRoot");
			exit(EXIT_SUCCESS);
		}
		rootmap[y][x] = f++;
		setStartRoot(rootmap, costmap, minusmap, plusmap, nextmap, x - 1, y, d, f, tp, MOVE_RIGHT);
		setStartRoot(rootmap, costmap, minusmap, plusmap, nextmap, x + 1, y, d, f, tp, MOVE_LEFT);
		setStartRoot(rootmap, costmap, minusmap, plusmap, nextmap, x, y - 1, d, f, tp, MOVE_DOWN);
		setStartRoot(rootmap, costmap, minusmap, plusmap, nextmap, x, y + 1, d, f, tp, MOVE_UP);
		/* seek to space position */
		{
			int sx = puzzle->space.x;
			int sy = puzzle->space.y;
			while (rootmap[sy][sx] == 0) {
				int next_f = f + 1;
				int flag = 0;
				for (y = 1; y <= Y_SIZE; y++) {
					for (x = 1; x <= X_SIZE; x++) {
						int c, pc, mc;
						if (rootmap[y][x] != f) {
							continue;
						}
						flag++;
						c = costmap[y][x];
						mc = minusmap[y][x];
						pc = plusmap[y][x];
						tp = number2postion(puzzle->table[y][x]);
						d = distance(tp, makePosition(x, y));
						seekNextRoot(rootmap, costmap, minusmap, plusmap, nextmap, x - 1, y, c, mc, pc, d, next_f, tp, MOVE_RIGHT);
						seekNextRoot(rootmap, costmap, minusmap, plusmap, nextmap, x + 1, y, c, mc, pc, d, next_f, tp, MOVE_LEFT);
						seekNextRoot(rootmap, costmap, minusmap, plusmap, nextmap, x, y - 1, c, mc, pc, d, next_f, tp, MOVE_DOWN);
						seekNextRoot(rootmap, costmap, minusmap, plusmap, nextmap, x, y + 1, c, mc, pc, d, next_f, tp, MOVE_UP);
					}
				}
				if (flag == 0) {
					return INT_MAX;
				}
				f = next_f;
			}
		}
	}
	/*
	printTable("rootmap", rootmap);
	printTable("costmap", costmap);
	printTable("nextmap", nextmap);
	printTable("minusmap", minusmap);
	printTable("plusmap", plusmap);
	*/
	return rootmap[puzzle->space.y][puzzle->space.x];
	/* return costmap[puzzle->space.y][puzzle->space.x]; */
}

void moveSpace(Puzzle *puzzle, const Table nextmap, const Position pos) {
	int x = puzzle->space.x;
	int y = puzzle->space.y;
	dputs("moveSpace");
	dcode(printf("px=%d py=%d\n", pos.x, pos.y));
	dcode(printTable("nextmap", nextmap));
	while (pos.x != x || pos.y != y) {
		dcode(printf("x=%d y=%d nm=%d\n", x, y, nextmap[y][x]));
		switch (nextmap[y][x]) {
		case MOVE_LEFT:
			moveLeftSpace(puzzle);
			break;
		case MOVE_RIGHT:
			moveRightSpace(puzzle);
			break;
		case MOVE_UP:
			moveUpSpace(puzzle);
			break;
		case MOVE_DOWN:
			moveDownSpace(puzzle);
			break;
		default:
			dputs("return");
			return;
		}
		x = puzzle->space.x;
		y = puzzle->space.y;
	}
	dputs("end");
}

Position searchNumber(Puzzle const *puzzle, const int number) {
	int i, j;
	for (i = 1; i <= Y_SIZE; i++) {
		for (j = 1; j <= X_SIZE; j++) {
			if (puzzle->table[i][j] == number) {
				return makePosition(j, i);
			}
		}
	}
	return makePosition(0, 0);
}

int searchRoot(const Table fixes, Table rootmap, const Position posFrom, const Position posTo) {
	if (fixes[posFrom.y][posFrom.x] == FIXED || fixes[posTo.y][posTo.x] == FIXED) {
		return 0;
	}
	/* init maps */
	{
		int x, y;
		for (y = 0; y < TABLE_Y_SIZE; y++) {
			for (x = 0; x < TABLE_X_SIZE; x++) {
				if (fixes[y][x] == FIXED) {
					rootmap[y][x] = -1;
				} else {
					rootmap[y][x] = 0;
				}
			}
		}
	}
	/* seek root */
	{
		int f = 1;
		int x = posTo.x;
		int y = posTo.y;
		rootmap[y][x] = f++;
		if (rootmap[y][x - 1] == 0) {
			rootmap[y][x - 1] = f;
		}
		if (rootmap[y][x + 1] == 0) {
			rootmap[y][x + 1] = f;
		}
		if (rootmap[y - 1][x] == 0) {
			rootmap[y - 1][x] = f;
		}
		if (rootmap[y + 1][x] == 0) {
			rootmap[y + 1][x] = f;
		}
		while (rootmap[posFrom.y][posFrom.x] == 0) {
			int next_f = f + 1;
			int flag = 0;
			for (y = 1; y <= Y_SIZE; y++) {
				for (x = 1; x <= X_SIZE; x++) {
					if (rootmap[y][x] != f) {
						continue;
					}
					flag++;
					if (rootmap[y][x - 1] == 0) {
						rootmap[y][x - 1] = next_f;
					}
					if (rootmap[y][x + 1] == 0) {
						rootmap[y][x + 1] = next_f;
					}
					if (rootmap[y - 1][x] == 0) {
						rootmap[y - 1][x] = next_f;
					}
					if (rootmap[y + 1][x] == 0) {
						rootmap[y + 1][x] = next_f;
					}
				}
			}
			if (flag == 0) {
				return -1;
			}
			f = next_f;
		}
	}
	return rootmap[posFrom.y][posFrom.x];
}

int moveNumber(Puzzle *puzzle, Table fixes, const int number, const Position pos1) {
	if (puzzle->table[pos1.y][pos1.x] == number) {
		return 0;
	}
	dputs("moveNumber");
	{
		Position pos2 = searchNumber(puzzle, number), pos3;
		int x = pos2.x;
		int y = pos2.y;
		Table rootmap, temp1, temp2, temp3, temp4;
		int r = searchRoot(fixes, rootmap, pos2, pos1) - 1;
		int z, mv, zz, f;
		if (r < 0) {
			return -1;
		}
		while (x != pos1.x || y != pos1.y) {
			dputs("loop head");
			zz = INT_MAX;
			mv = 0;
			f = fixes[y][x];
			fixes[y][x] = FIXED;
			if (rootmap[y][x - 1] == r) {
				z = searchSpaceRoot(puzzle, fixes, temp2, pos2 = makePosition(x - 1, y));
				if (z < INT_MAX) {
					mv = MOVE_RIGHT;
					zz = z;
					pos3 = pos2;
				}
			}
			if (rootmap[y][x + 1] == r) {
				z = searchSpaceRoot(puzzle, fixes, temp1, pos2 = makePosition(x + 1, y));
				if (z < INT_MAX && (z < zz)) {
					mv = MOVE_LEFT;
					zz = z;
					pos3 = pos2;
				}
			}
			if (rootmap[y - 1][x] == r) {
				z = searchSpaceRoot(puzzle, fixes, temp4, pos2 = makePosition(x, y - 1));
				if (z < INT_MAX && (z < zz)) {
					mv = MOVE_DOWN;
					zz = z;
					pos3 = pos2;
				}
			}
			if (rootmap[y + 1][x] == r) {
				z = searchSpaceRoot(puzzle, fixes, temp3, pos2 = makePosition(x, y + 1));
				if (z < INT_MAX && (z < zz)) {
					mv = MOVE_UP;
					pos3 = pos2;
				}
			}
			fixes[y][x] = f;
			dcode(printTable("rootmap", rootmap));
			dcode(printf("number=%d x=%d y=%d x3=%d y3=%d mv=%d r=%d\n", number, x, y, pos3.x, pos3.y, mv, r));
			switch (mv) {
			case MOVE_LEFT:
				moveSpace(puzzle, temp1, pos3);
				moveLeftSpace(puzzle);
				break;
			case MOVE_RIGHT:
				moveSpace(puzzle, temp2, pos3);
				moveRightSpace(puzzle);
				break;
			case MOVE_UP:
				moveSpace(puzzle, temp3, pos3);
				moveUpSpace(puzzle);
				break;
			case MOVE_DOWN:
				moveSpace(puzzle, temp4, pos3);
				moveDownSpace(puzzle);
				break;
			default:
				/* error */
				return -3;
			}
			x = pos3.x;
			y = pos3.y;
			r--;
		}
	}
	return 1;
}

void moveRight2Numbers(Puzzle *puzzle, Table fixes, const int x, const int y, int n) {
	int m = n++;
	Position pos1 = makePosition(x, y);
	Position pos2 = makePosition(x + 1, y);
	Position pos3 = makePosition(x, y + 1);
	Position pos4 = makePosition(x + 1, y + 1);
	dcode(printf("moveRight2Numbers x=%d y=%d n=%d\n", x, y, m));
	for (;;) {
		Table nextmap;
		int p1 = puzzle->table[y][x];
		int p2 = puzzle->table[y][x + 1];
		int p3 = puzzle->table[y + 1][x];
		int p4 = puzzle->table[y + 1][x + 1];
		dputs("loop head");
		if (p1 == m && p2 == n) {
			dputs("OK");
			break;
		} else
		if (p1 != m && p1 != n && p2 != m && p2 != n) {
			Table tempM, tempN;
			Position posM = searchNumber(puzzle, m);
			Position posN = searchNumber(puzzle, n);
			int rM = searchRoot(fixes, tempM, posM, pos2);
			int rN = searchRoot(fixes, tempN, posN, pos1);
			dputs("not found case");
			if (rM >= 0 && rM < rN) {
				if (moveNumber(puzzle, fixes, m, pos2) < 0) {
					printPuzzle(puzzle);
					puts("error");
					return;
				}
			} else if (rN >= 0) {
				if (moveNumber(puzzle, fixes, n, pos1) < 0) {
					printPuzzle(puzzle);
					puts("error2");
					return;
				}
			} else {
				printPuzzle(puzzle);
				puts("error3");
				return;
			}
			continue;
		} else
		if ((p1 == m && p2 == 0 && p4 == n) || (p1 == 0 && p2 == n && p3 == m)) {
			dputs("rare case");
			moveDownSpace(puzzle);
			dputs("OK2");
			break;
		} else
		if (p1 == n && p3 == m) {
			int f3 = fixes[pos3.y][pos3.x];
			dputs("p1==n&&p3==m");
			fixes[pos1.y][pos1.x] = FIXED;
			fixes[pos3.y][pos3.x] = FIXED;
			if (searchSpaceRoot(puzzle, fixes, nextmap, pos2) == INT_MAX) {
				printPuzzle(puzzle);
				puts("error");
				return;
			}
			fixes[pos3.y][pos3.x] = f3;
			moveSpace(puzzle, nextmap, pos2);
			moveLeftSpace(puzzle);
			moveDownSpace(puzzle);
			dputs("OK3");
			break;
		} else
		if (p2 == m && p4 == n) {
			int f4 = fixes[pos4.y][pos4.x];
			dputs("p2==m&&p4==n");
			fixes[pos2.y][pos2.x] = FIXED;
			fixes[pos4.y][pos4.x] = FIXED;
			if (searchSpaceRoot(puzzle, fixes, nextmap, pos1) == INT_MAX) {
				printPuzzle(puzzle);
				puts("error");
				return;
			}
			fixes[pos4.y][pos4.x] = f4;
			moveSpace(puzzle, nextmap, pos1);
			moveRightSpace(puzzle);
			moveDownSpace(puzzle);
			dputs("OK4");
			break;
		} else
		if (p1 == 0 && p2 == m && p3 == n) {
			moveRightSpace(puzzle);
			continue;
		} else
		if (p1 == n && p2 == 0 && p4 == m) {
			moveDownSpace(puzzle);
			moveLeftSpace(puzzle);
			moveUpSpace(puzzle);
			moveRightSpace(puzzle);
			continue;
		} else
		if (p1 == n && p2 == m) {
			searchSpaceRoot(puzzle, fixes, nextmap, pos3);
			moveSpace(puzzle, nextmap, pos3);
			moveUpSpace(puzzle);
			moveRightSpace(puzzle);
			continue;
		} else
		if (p2 == n && p4 == m) {
			if (p1 == 0) {
				moveRightSpace(puzzle);
				moveDownSpace(puzzle);
				continue;
			} else
			if (p3 == 0) {
				moveUpSpace(puzzle);
				moveRightSpace(puzzle);
				moveDownSpace(puzzle);
				continue;
			} else {
				Position pos = makePosition(x, y + 2);
				searchSpaceRoot(puzzle, fixes, nextmap, pos);
				moveSpace(puzzle, nextmap, pos);
				moveUpSpace(puzzle);
				moveUpSpace(puzzle);
				moveRightSpace(puzzle);
				moveDownSpace(puzzle);
				continue;
			}
		} else
		if (p1 == m && p3 == n) {
			Position pos = makePosition(x + 1, y + 2);
			int f = fixes[pos.y][pos.x];
			dputs("wrong case (move n)");
			dcode(printTable("fixes", fixes));
			if (moveNumber(puzzle, fixes, n, pos) < 0) {
				printPuzzle(puzzle);
				printf("error in moveRight2Numbers(): n pos %d\n", m);
				return;
			}
			dputs("wrong case (move m)");
			dcode(printTable("fixes", fixes));
			fixes[pos.y][pos.x] = FIXED;
			if (moveNumber(puzzle, fixes, m, pos2) < 0) {
				printPuzzle(puzzle);
				printf("error in moveRight2Numbers(): m pos2 %d\n", m);
				return;
			}
			fixes[pos.y][pos.x] = f;
			continue;
		} else
		if (p1 == m) {
			int f1 = fixes[pos1.y][pos1.x];
			dputs("p1==m");
			fixes[pos1.y][pos1.x] = FIXED;
			if (searchSpaceRoot(puzzle, fixes, nextmap, pos2) == INT_MAX) {
				printPuzzle(puzzle);
				puts("error");
				return;
			}
			fixes[pos1.y][pos1.x] = f1;
			moveSpace(puzzle, nextmap, pos2);
			moveLeftSpace(puzzle);
			continue;
		} else
		if (p2 == n) {
			int f2 = fixes[pos2.y][pos2.x];
			dputs("p2==n");
			fixes[pos2.y][pos2.x] = FIXED;
			if (searchSpaceRoot(puzzle, fixes, nextmap, pos1) == INT_MAX) {
				printPuzzle(puzzle);
				puts("error");
				return;
			}
			fixes[pos2.y][pos2.x] = f2;
			moveSpace(puzzle, nextmap, pos1);
			moveRightSpace(puzzle);
			continue;
		} else
		if (p1 == n) {
			int f1 = fixes[pos1.y][pos1.x];
			dputs("p1==n");
			fixes[pos1.y][pos1.x] = FIXED;
			if (moveNumber(puzzle, fixes, m, pos3) < 0) {
				printPuzzle(puzzle);
				printf("error in moveRight2Numbers(): p1==n %d\n", m);
				return;
			}
			fixes[pos1.y][pos1.x] = f1;
			continue;
		} else
		if (p2 == m) {
			int f2 = fixes[pos2.y][pos2.x];
			dputs("p2==m");
			fixes[pos2.y][pos2.x] = FIXED;
			if (moveNumber(puzzle, fixes, n, pos4) < 0) {
				printPuzzle(puzzle);
				printf("error in moveRight2Numbers(): p2==m %d\n", m);
				return;
			}
			fixes[pos2.y][pos2.x] = f2;
			continue;
		} else {
			printPuzzle(puzzle);
			puts("error dayo");
			return;
		}
	}
	fixes[pos1.y][pos1.x] = FIXED;
	fixes[pos2.y][pos2.x] = FIXED;
}



void moveLeft2Numbers(Puzzle *puzzle, Table fixes, const int x, const int y, int n) {
	int m = n;
	Position pos1 = makePosition(x, y);
	Position pos2 = makePosition(x, y + 1);
	Position pos3 = makePosition(x + 1, y);
	Position pos4 = makePosition(x + 1, y + 1);
	n += X_SIZE;
	dcode(printf("moveLeft2Numbers x=%d y=%d n=%d\n", x, y, m));
	for (;;) {
		Table nextmap;
		int p1 = puzzle->table[y][x];
		int p2 = puzzle->table[y + 1][x];
		int p3 = puzzle->table[y][x + 1];
		int p4 = puzzle->table[y + 1][x + 1];
		dputs("loop head");
		if (p1 == m && p2 == n) {
			dputs("OK");
			break;
		} else
		if (p1 != m && p1 != n && p2 != m && p2 != n) {
			Table tempM, tempN;
			Position posM = searchNumber(puzzle, m);
			Position posN = searchNumber(puzzle, n);
			int rM = searchRoot(fixes, tempM, posM, pos2);
			int rN = searchRoot(fixes, tempN, posN, pos1);
			dputs("not found case");
			if (rM >= 0 && rM < rN) {
				if (moveNumber(puzzle, fixes, m, pos2) < 0) {
					printPuzzle(puzzle);
					puts("error");
					return;
				}
			} else if (rN >= 0) {
				if (moveNumber(puzzle, fixes, n, pos1) < 0) {
					printPuzzle(puzzle);
					puts("error2");
					return;
				}
			} else {
				printPuzzle(puzzle);
				puts("error3");
				return;
			}
			continue;
		} else
		if ((p1 == m && p2 == 0 && p4 == n) || (p1 == 0 && p2 == n && p3 == m)) {
			dputs("rare case");
			moveRightSpace(puzzle);
			dputs("OK2");
			break;
		} else
		if (p1 == n && p3 == m) {
			int f3 = fixes[pos3.y][pos3.x];
			dputs("p1==n&&p3==m");
			fixes[pos1.y][pos1.x] = FIXED;
			fixes[pos3.y][pos3.x] = FIXED;
			if (searchSpaceRoot(puzzle, fixes, nextmap, pos2) == INT_MAX) {
				printPuzzle(puzzle);
				puts("error");
				return;
			}
			fixes[pos3.y][pos3.x] = f3;
			moveSpace(puzzle, nextmap, pos2);
			moveUpSpace(puzzle);
			moveRightSpace(puzzle);
			dputs("OK3");
			break;
		} else
		if (p2 == m && p4 == n) {
			int f4 = fixes[pos4.y][pos4.x];
			dputs("p2==m&&p4==n");
			fixes[pos2.y][pos2.x] = FIXED;
			fixes[pos4.y][pos4.x] = FIXED;
			if (searchSpaceRoot(puzzle, fixes, nextmap, pos1) == INT_MAX) {
				printPuzzle(puzzle);
				puts("error");
				return;
			}
			fixes[pos4.y][pos4.x] = f4;
			moveSpace(puzzle, nextmap, pos1);
			moveDownSpace(puzzle);
			moveRightSpace(puzzle);
			dputs("OK4");
			break;
		} else
		if (p1 == 0 && p2 == m && p3 == n) {
			moveDownSpace(puzzle);
			continue;
		} else
		if (p1 == n && p2 == 0 && p4 == m) {
			moveRightSpace(puzzle);
			moveUpSpace(puzzle);
			moveLeftSpace(puzzle);
			moveDownSpace(puzzle);
			continue;
		} else
		if (p1 == n && p2 == m) {
			searchSpaceRoot(puzzle, fixes, nextmap, pos3);
			moveSpace(puzzle, nextmap, pos3);
			moveLeftSpace(puzzle);
			moveDownSpace(puzzle);
			continue;
		} else
		if (p2 == n && p4 == m) {
			if (p1 == 0) {
				moveDownSpace(puzzle);
				moveRightSpace(puzzle);
				continue;
			} else
			if (p3 == 0) {
				moveLeftSpace(puzzle);
				moveDownSpace(puzzle);
				moveRightSpace(puzzle);
				continue;
			} else {
				Position pos = makePosition(x + 2, y);
				searchSpaceRoot(puzzle, fixes, nextmap, pos);
				moveSpace(puzzle, nextmap, pos);
				moveLeftSpace(puzzle);
				moveLeftSpace(puzzle);
				moveDownSpace(puzzle);
				moveRightSpace(puzzle);
				continue;
			}
		} else
		if (p1 == m && p3 == n) {
			Position pos = makePosition(x + 2, y + 1);
			int f = fixes[pos.y][pos.x];
			dputs("wrong case (move n)");
			dcode(printTable("fixes", fixes));
			if (moveNumber(puzzle, fixes, n, pos) < 0) {
				printPuzzle(puzzle);
				printf("error in moveLeft2Numbers(): n pos %d\n", m);
				return;
			}
			dputs("wrong case (move m)");
			dcode(printTable("fixes", fixes));
			fixes[pos.y][pos.x] = FIXED;
			if (moveNumber(puzzle, fixes, m, pos2) < 0) {
				printPuzzle(puzzle);
				printf("error in moveLeft2Numbers(): m pos2 %d\n", m);
				return;
			}
			fixes[pos.y][pos.x] = f;
			continue;
		} else
		if (p1 == m) {
			int f1 = fixes[pos1.y][pos1.x];
			dputs("p1==m");
			fixes[pos1.y][pos1.x] = FIXED;
			if (searchSpaceRoot(puzzle, fixes, nextmap, pos2) == INT_MAX) {
				printPuzzle(puzzle);
				puts("error");
				return;
			}
			fixes[pos1.y][pos1.x] = f1;
			moveSpace(puzzle, nextmap, pos2);
			moveUpSpace(puzzle);
			continue;
		} else
		if (p2 == n) {
			int f2 = fixes[pos2.y][pos2.x];
			dputs("p2==n");
			fixes[pos2.y][pos2.x] = FIXED;
			if (searchSpaceRoot(puzzle, fixes, nextmap, pos1) == INT_MAX) {
				printPuzzle(puzzle);
				puts("error");
				return;
			}
			fixes[pos2.y][pos2.x] = f2;
			moveSpace(puzzle, nextmap, pos1);
			moveDownSpace(puzzle);
			continue;
		} else
		if (p1 == n) {
			int f1 = fixes[pos1.y][pos1.x];
			dputs("p1==n");
			fixes[pos1.y][pos1.x] = FIXED;
			if (moveNumber(puzzle, fixes, m, pos3) < 0) {
				printPuzzle(puzzle);
				printf("error in moveLeft2Numbers(): p1==n %d\n", m);
				return;
			}
			fixes[pos1.y][pos1.x] = f1;
			continue;
		} else
		if (p2 == m) {
			int f2 = fixes[pos2.y][pos2.x];
			dputs("p2==m");
			fixes[pos2.y][pos2.x] = FIXED;
			if (moveNumber(puzzle, fixes, n, pos4) < 0) {
				printPuzzle(puzzle);
				printf("error in moveLeft2Numbers(): p2==m %d\n", m);
				return;
			}
			fixes[pos2.y][pos2.x] = f2;
			continue;
		} else {
			printPuzzle(puzzle);
			puts("error dayo");
			return;
		}
	}
	fixes[pos1.y][pos1.x] = FIXED;
	fixes[pos2.y][pos2.x] = FIXED;
}
