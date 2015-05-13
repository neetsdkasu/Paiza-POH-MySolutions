// 15 puzzle solver
// 2015-05-3
// Leonardone @ NEETSDKASU
#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <cstdlib>
#include <ctime>
#include <cctype>

#if __BORLANDC__
typedef unsigned __int64 uint64;
#else
typedef unsigned long long uint64;
#endif

#define BEGIN_OF_NAMESPACE namespace neetsdkasu {
#define END_OF_NAMESPACE }


////////////////////////////////////////////////////

BEGIN_OF_NAMESPACE
	
	typedef int PuzzleArray[16];
	
	class PuzzleState {
	public:
		static int Shift(int index) { return 60 - ((index & 0xf) << 2); }
		static int GetNumber(uint64 data, int index) { return int((data >> Shift(index)) & uint64(0xf)); }
		static int GetIndex(uint64 data, int number);
		static uint64 SetNumber(uint64 data, int index, int number);
		PuzzleState() : data(uint64(0x123456789abcdef0)), zero(uint64(0xf)) {}
		PuzzleState(uint64 data) : data(data), zero(uint64(0xf) << Shift(GetIndex(data, 0))) {}
		PuzzleState(PuzzleArray array);
		PuzzleState MoveLeft() {
			return ((zero & uint64(0xF000F000F000F000)) == uint64(0)) ?
				PuzzleState((data & (~(zero << 4))) | ((data & (zero << 4)) >> 4), zero << 4) : *this;
		}
		PuzzleState MoveRight() {
			return ((zero & uint64(0x000F000F000F000F)) == uint64(0)) ?
				PuzzleState((data & (~(zero >> 4))) | ((data & (zero >> 4)) << 4), zero >> 4) : *this;
		}
		PuzzleState MoveUp() {
			return ((zero & uint64(0xFFFF000000000000)) == uint64(0)) ?
				PuzzleState((data & (~(zero << 16))) | ((data & (zero << 16)) >> 16), zero << 16) : *this;
		}
		PuzzleState MoveDown() {
			return ((zero & uint64(0x000000000000FFFF)) == uint64(0)) ?
				PuzzleState((data & (~(zero >> 16))) | ((data & (zero >> 16)) << 16), zero >> 16) : *this;
		}
		int NumberOf(int index) { return GetNumber(data, index); }
		int IndexOf(int number) { return GetIndex(data, number); }
		uint64 Data() { return data; }
		uint64 Zero() { return zero; }
		PuzzleState Move(int k);
		PuzzleState MoveNumber(int number);
		PuzzleState Shuffle(int count);
		void Print();
	private:
		PuzzleState(uint64 data, uint64 zero) : data(data), zero(zero) {}
		uint64 data, zero;
	};
	
	PuzzleState InputPuzzle();
	
	void CheckRoot(PuzzleState problem, std::vector<int> &root);
	
	PuzzleState SolveAPart(PuzzleState startPuzzle, uint64 goal, uint64 unmovable, std::vector<int> &root);
	
	void Solve(PuzzleState problem, std::vector<int> &root);
	
#define SolveFunc(num) void Solve##num(PuzzleState puzzle, std::vector<int> &root);
	
	SolveFunc(1);
	SolveFunc(2);
	SolveFunc(3);
	SolveFunc(4);

END_OF_NAMESPACE

////////////////////////////////////////////////////


int main() {

#ifdef DEBUG
	neetsdkasu::PuzzleState problem = neetsdkasu::PuzzleState().Shuffle(500);
	problem.Print();
#else
	neetsdkasu::PuzzleState problem = neetsdkasu::InputPuzzle();
#endif
	
	std::vector<int> root;
	neetsdkasu::Solve(problem, root);
	
	for (std::vector<int>::iterator it = root.begin(); it != root.end(); it++) {
		std::cout << *it << std::endl;
	}
	
#ifdef DEBUG
	neetsdkasu::CheckRoot(problem, root);
#endif
	
	return 0;
}

////////////////////////////////////////////////////

BEGIN_OF_NAMESPACE
	
	PuzzleState InputPuzzle() {
		PuzzleArray array;
		for (int i = 0; i < 16; i++) {
			std::string str;
			std::cin >> str;
			if (str == "*") {
				array[i] = 0;
			} else {
				array[i] = std::atoi(str.c_str());
			}
		}
		return PuzzleState(array);
	}
	
	void CheckRoot(PuzzleState problem, std::vector<int> &root) {
		PuzzleState checker = problem;
		for (std::vector<int>::iterator it = root.begin(); it != root.end(); it++) {
			checker = checker.MoveNumber(*it);
		}
		checker.Print();
		std::cout << "step: " << root.size() << std::endl;
		std::cout << ((checker.Data() == uint64(0x123456789abcdef0)) ? "OK" : "NG") << std::endl;
	}
	
	PuzzleState::PuzzleState(PuzzleArray array) : data(uint64(0)), zero(uint64(0xf)) {
		for (int i = 0; i < 16; i++) {
			data = SetNumber(data, i, array[i]);
			if (array[i] == 0) {
				zero <<= Shift(i);
			}
		}
	}
	
	int PuzzleState::GetIndex(uint64 data, int number) {
		for (int i = 0; i < 16; i++) {
			if (GetNumber(data, i) == number) {
				return i;
			}
		}
		return -1;
	}
	
	uint64 PuzzleState::SetNumber(uint64 data, int index, int number) {
		int sh = Shift(index);
		return (data & (~(uint64(0xf) << sh))) | (uint64(number & 0xf) << sh);
	}
	
	PuzzleState PuzzleState::Move(int k) {
		switch (k & 3) {
			case 0:
				return MoveLeft();
			case 1:
				return MoveRight();
			case 2:
				return MoveUp();
			case 3:
				return MoveDown();
			default:
				return *this;
		}
	}
	
	PuzzleState PuzzleState::MoveNumber(int number) {
		switch (IndexOf(number) - IndexOf(0)) {
			case -4:
				return MoveUp();
			case -1:
				return MoveLeft();
			case 1:
				return MoveRight();
			case 4:
				return MoveDown();
			default:
				return *this;
		}
	}
	
	PuzzleState PuzzleState::Shuffle(int count) {
		PuzzleState temp = *this;
		std::srand((unsigned)std::time(NULL));
		for (int i = 0; i < count; i++) {
			temp = temp.Move((std::rand() & 1) + ((i & 1) << 1));
		}
		return temp;
	}
	
	void PuzzleState::Print() {
		std::cout << "--------------" << std::endl;
		for (int i = 0; i < 16; i++) {
			if ((i & 3) > 0) {
				std::cout << ' ';
			}
			std::cout.width(2);
			int number = NumberOf(i);
			if (number == 0) {
				std::cout << " *";
			} else {
				std::cout << number;
			}
			if ((i & 3) == 3) {
				std::cout << std::endl;
			}
			
		}
	}
	
	PuzzleState SolveAPart(PuzzleState startPuzzle, uint64 goal, uint64 unmovable, std::vector<int> &root) {
		uint64 startState = uint64(0xBBBBBBBBBBBBBBBB) & (~startPuzzle.Zero());
		uint64 goalState = goal;
		for (int i = 0; i < 16; i++) {
			int n = PuzzleState::GetNumber(goal, i);
			if (n == 0) {
				goalState = PuzzleState::SetNumber(goalState, i, 0xb);
			} else {
				int j = startPuzzle.IndexOf(n);
				if (j >= 0) {
					startState = PuzzleState::SetNumber(startState, j, n);
				}
			}
		}
		
		std::map<uint64, uint64> allRoots;
		std::vector<PuzzleState> currentStates;
		
		for (int i = 0; i < 16; i++) {
			if (PuzzleState::GetNumber(goalState, i) == 0xb) {
				uint64 data = PuzzleState::SetNumber(goalState, i, 0);
				allRoots[data] = uint64(0);
				currentStates.push_back(PuzzleState(data));
			}
		}
		
		if (allRoots.find(startState) != allRoots.end()) {
			return startPuzzle;
		}
		
		std::vector<PuzzleState> nextStates;
		
		while (!currentStates.empty()) {
			nextStates.clear();
			for (std::vector<PuzzleState>::iterator it = currentStates.begin(); it != currentStates.end(); it++) {
				for (int k = 0; k < 4; k++) {
					PuzzleState tempPuzzle = it->Move(k);
					if (tempPuzzle.Data() == it->Data()) {
						continue;
					}
					if ((tempPuzzle.Zero() & unmovable) > uint64(0)) {
						continue;
					}
					if (allRoots.find(tempPuzzle.Data()) != allRoots.end()) {
						continue;
					}
					allRoots[tempPuzzle.Data()] = it->Data();
					nextStates.push_back(tempPuzzle);
					if (tempPuzzle.Data() == startState) {
						goto loopout;
					}
				}
			}
			currentStates.clear();
			currentStates.insert(currentStates.begin(), nextStates.begin(), nextStates.end());
		}
		loopout:
		
		if (allRoots.find(startState) == allRoots.end()) {
			return startPuzzle;
		}
		
		PuzzleState nextPuzzle = startPuzzle;
		uint64 temp = allRoots[startState];
		while (temp != uint64(0)) {
			int i = PuzzleState::GetIndex(temp, 0);
			int n = nextPuzzle.NumberOf(i);
			nextPuzzle = nextPuzzle.MoveNumber(n);
			root.push_back(n);
			temp = allRoots[temp];
		}
		
		return nextPuzzle;
	}
	
#define DoSolve(num) \
	temp.clear(); \
	Solve##num(problem, temp); \
	if (temp.size() < root.size()) { \
		root.clear(); \
		root.insert(root.begin(), temp.begin(), temp.end()); \
	}
	
	void Solve(PuzzleState problem, std::vector<int> &root) {
		std::vector<int> temp;

		Solve1(problem, root);
		
		DoSolve(2);
		DoSolve(3);
		DoSolve(4);
	}
	
#define DefineSolveFunc(num, g1, u1, g2, u2, g3, u3, g4, u4, g5, u5, u6) \
	void Solve##num(PuzzleState puzzle, std::vector<int> &root) { \
		puzzle = SolveAPart(puzzle, uint64(g1), uint64(u1), root); \
		puzzle = SolveAPart(puzzle, uint64(g2), uint64(u2), root); \
		puzzle = SolveAPart(puzzle, uint64(g3), uint64(u3), root); \
		puzzle = SolveAPart(puzzle, uint64(g4), uint64(u4), root); \
		puzzle = SolveAPart(puzzle, uint64(g5), uint64(u5), root); \
		         SolveAPart(puzzle, uint64(0x123456789abcdef0), uint64(u6), root); \
	}
	
	DefineSolveFunc( 1, 
		0x1200000000000000, 0,
		0x1234000000000000, 0xff00000000000000, // 1122
		0x1234560000000000, 0xffff000000000000, // 3344
		0x1234567800000000, 0xffffff0000000000, // 5
		0x123456789000d000, 0xffffffff00000000, // 5
		                    0xfffffffff000f000)

	DefineSolveFunc( 2, 
		0x1200000000000000, 0,
		0x1200560000000000, 0xff00000000000000, // 1133
		0x1234560000000000, 0xff00ff0000000000, // 2244
		0x1234567800000000, 0xffffff0000000000, // 5
		0x123456789000d000, 0xffffffff00000000, // 5
		                    0xfffffffff000f000)
	
	DefineSolveFunc( 3, 
		0x1200000000000000, 0,
		0x1200560000000000, 0xff00000000000000, // 1155
		0x120056009000d000, 0xff00ff0000000000, // 22
		0x120056009a00de00, 0xff00ff00f000f000, // 34
		0x123456009a00de00, 0xff00ff00ff00ff00, // 34
		                    0xffffff00ff00ff00)
	
	DefineSolveFunc( 4, 
		0x1200000000000000, 0,
		0x1200560000000000, 0xff00000000000000, // 1144
		0x120056009000d000, 0xff00ff0000000000, // 22
		0x123456009000d000, 0xff00ff00f000f000, // 35
		0x123456009a00de00, 0xffffff00f000f000, // 35
		                    0xffffff00ff00ff00)
	
END_OF_NAMESPACE

