// 15 puzzle solver
// 2015-05-13
// Leonardone @ NEETSDKASU
#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <cstdlib>
#include <ctime>
#include <cctype>

#ifdef __BORLANDC__
typedef unsigned __int64 uint64;
#else
typedef unsigned long long uint64;
#endif

#define BEGIN_OF_NAMESPACE namespace neetsdkasu {
#define END_OF_NAMESPACE }


////////////////////////////////////////////////////

BEGIN_OF_NAMESPACE
	
	typedef int PuzzleArray[16];
	typedef std::vector<int> Root;
	
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
	
	void CheckRoot(PuzzleState problem, Root &root);
	
	PuzzleState SolveAPart(PuzzleState startPuzzle, uint64 goal, uint64 unmovable, Root &root);
	
	void Solve(PuzzleState problem, Root &root);
	
END_OF_NAMESPACE

////////////////////////////////////////////////////

int main() {

#ifdef DEBUG
	neetsdkasu::PuzzleState problem = neetsdkasu::PuzzleState().Shuffle(500);
	problem.Print();
#else
	neetsdkasu::PuzzleState problem = neetsdkasu::InputPuzzle();
#endif
	
	neetsdkasu::Root root;
	neetsdkasu::Solve(problem, root);
	
	for (neetsdkasu::Root::iterator it = root.begin(); it != root.end(); it++) {
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
	
	void CheckRoot(PuzzleState problem, Root &root) {
		PuzzleState checker = problem;
		for (Root::iterator it = root.begin(); it != root.end(); it++) {
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
	
	PuzzleState SolveAPart(PuzzleState startPuzzle, uint64 goal, uint64 unmovable, Root &root) {
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
		std::vector<PuzzleState> currentStates, nextStates;
		
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
	
#define SOLVE1(_G, _U) \
	Root tempRoot = it->second; \
	PuzzleState tempPuzzle = SolveAPart(puzzle, uint64(_G), uint64(_U), tempRoot); \
	if (nextStates.find(tempPuzzle.Data()) == nextStates.end()) { \
		nextStates[tempPuzzle.Data()] = tempRoot; \
	} else if (tempRoot.size() < nextStates[tempPuzzle.Data()].size()) { \
		nextStates[tempPuzzle.Data()] = tempRoot; \
	}
	
	void Solve(PuzzleState problem, Root &root) {
		std::map<uint64, Root> currentStates, nextStates;
		std::vector<Root> roots;
		
		currentStates[problem.Data()] = root;
		
		for (int i = 0; i < 10; i++) {
		
			nextStates.clear();
			for (std::map<uint64, Root>::iterator it = currentStates.begin(); it != currentStates.end(); it++) {
				PuzzleState puzzle(it->first);
				int flag = 0;
				if ((puzzle.Data() & uint64(0xffffff00ff00ff00)) == uint64(0x123456009a00de00)) {
					// 1234 >
					// 5600 >
					// 9a00 >
					// de00 >
					Root tempRoot = it->second;
					SolveAPart(puzzle, uint64(0x123456789abcdef0), uint64(0xffffff00ff00ff00), tempRoot);
					roots.push_back(tempRoot);
					continue;
				}
				if ((puzzle.Data() & uint64(0xfffffffff000f000)) == uint64(0x123456789000d000)) {
					// 1234 >
					// 5678 >
					// 9000 >
					// d000 >
					Root tempRoot = it->second;
					SolveAPart(puzzle, uint64(0x123456789abcdef0), uint64(0xfffffffff000f000), tempRoot);
					roots.push_back(tempRoot);
					continue;
				}
				if ((puzzle.Data() & uint64(0xffffff00f000f000)) == uint64(0x123456009000d000)) {
					{
						// 1234 > 1234
						// 5600 > 5600
						// 9000 > 9a00
						// d000 > de00
						SOLVE1(0x123456009a00de00, 0xffffff00f000f000);
					}
					{
						// 1234 > 1234
						// 5600 > 5678
						// 9000 > 9000
						// d000 > d000
						SOLVE1(0x123456789000d000, 0xffffff00f000f000);
					}
					continue;
				}
				if ((puzzle.Data() & uint64(0xffffffff00000000)) == uint64(0x1234567800000000)) {
					// 1234 > 1234
					// 5678 > 5678
					// 0000 > 9000
					// 0000 > d000
					SOLVE1(0x123456789000d000, 0xffffffff00000000);
					continue;
				}
				if ((puzzle.Data() & uint64(0xff00ff00ff00ff00)) == uint64(0x120056009a00de00)) {
					// 1200 > 1234
					// 5600 > 5600
					// 9a00 > 9a00
					// de00 > de00
					SOLVE1(0x123456009a00de00, 0xffffff00f000f000);
					continue;
				}
				if ((puzzle.Data() & uint64(0xf000f000ff00ff00)) == uint64(0x100050009a00de00)) {
					// 1000 > 1200
					// 5000 > 5600
					// 9a00 > 9a00
					// de00 > de00
					SOLVE1(0x120056009a00de00, 0xf000f000ff00ff00);
					continue;
				}
				if ((puzzle.Data() & uint64(0xff00ff00f000f000)) == uint64(0x120056009000d000)) {
					{
						// 1200 > 1200
						// 5600 > 5600
						// 9000 > 9a00
						// d000 > de00
						SOLVE1(0x120056009a00de00, 0xff00ff00f000f000);
					}
					{
						// 1200 > 1234
						// 5600 > 5600
						// 9000 > 9000
						// d000 > d000
						SOLVE1(0x123456009000d000, 0xff00ff00f000f000);
					}
					flag = 1;
				}
				if ((puzzle.Data() & uint64(0xffffff0000000000)) == uint64(0x1234560000000000)) {
					{
						// 1234 > 1234
						// 5600 > 5678
						// 0000 > 0000
						// 0000 > 0000
						SOLVE1(0x1234567800000000, 0xffffff0000000000);
					}
					{
						// 1234 > 1234
						// 5600 > 5600
						// 0000 > 9000
						// 0000 > d000
						SOLVE1(0x123456009000d000, 0xffffff0000000000);
					}
					flag = 1;
				}
				if ((puzzle.Data() & uint64(0xffff00ff00000000)) == uint64(0x1234007800000000)) {
					// 1234 > 1234
					// 0078 > 5678
					// 0000 > 0000
					// 0000 > 0000
					SOLVE1(0x1234567800000000, 0xffff00ff00000000);
					flag = 1;
				}
				if (flag == 1) {
					continue;
				}
				if ((puzzle.Data() & uint64(0xffff000000000000)) == uint64(0x1234000000000000)) {
					{
						// 1234 > 1234
						// 0000 > 5600
						// 0000 > 0000
						// 0000 > 0000
						SOLVE1(0x1234560000000000, 0xffff000000000000);
					}
					{
						// 1234 > 1234
						// 0000 > 0078
						// 0000 > 0000
						// 0000 > 0000
						SOLVE1(0x1234007800000000, 0xffff000000000000);
					}
					flag = 1;
				}
				if ((puzzle.Data() & uint64(0xff00ff0000000000)) == uint64(0x1200560000000000)) {
					{
						// 1200 > 1234
						// 5600 > 5600
						// 0000 > 0000
						// 0000 > 0000
						SOLVE1(0x1234560000000000, 0xff00ff0000000000);
					}
					{
						// 1200 > 1200
						// 5600 > 5600
						// 0000 > 9000
						// 0000 > d000
						SOLVE1(0x120056009000d000, 0xff00ff0000000000);
					}
					flag = 1;
				}
				if ((puzzle.Data() & uint64(0xf000f000f000f000)) == uint64(0x100050009000d000)) {
					{
						// 1000 > 1200
						// 5000 > 5600
						// 9000 > 9000
						// d000 > d000
						SOLVE1(0x120056009000d000, 0xf000f000f000f000);
					}
					{
						// 1000 > 1000
						// 5000 > 5000
						// 9000 > 9a00
						// d000 > de00
						SOLVE1(0x100050009a00de00, 0xf000f000f000f000);
					}
					flag = 1;
				}
				if ((puzzle.Data() & uint64(0x00ff00ff00000000)) == uint64(0x0034007800000000)) {
					// 0034 > 1234
					// 0078 > 0078
					// 0000 > 0000
					// 0000 > 0000
					SOLVE1(0x1234007800000000, 0x00ff00ff00000000);
					flag = 1;
				}
				if ((puzzle.Data() & uint64(0x00000000ff00ff00)) == uint64(0x000000009a00de00)) {
					// 0000 > 1000
					// 0000 > 5000
					// 9a00 > 9a00
					// de00 > de00
					SOLVE1(0x100050009a00de00, 0x00000000ff00ff00);
					flag = 1;
				}
				if (flag == 1) {
					continue;
				}
				if ((puzzle.Data() & uint64(0xff00000000000000)) == uint64(0x1200000000000000)) {
					{
						// 1200 > 1234
						// 0000 > 0000
						// 0000 > 0000
						// 0000 > 0000
						SOLVE1(0x1234000000000000, 0xff00000000000000);
					}
					{
						// 1200 > 1200
						// 0000 > 5600
						// 0000 > 0000
						// 0000 > 0000
						SOLVE1(0x1200560000000000, 0xff00000000000000);
					}
					flag = 1;
				}
				if ((puzzle.Data() & uint64(0xf000f00000000000)) == uint64(0x1000500000000000)) {
					{
						// 1000 > 1200
						// 5000 > 5600
						// 0000 > 0000
						// 0000 > 0000
						SOLVE1(0x1200560000000000, 0xf000f00000000000);
					}
					{
						// 1000 > 1000
						// 5000 > 5000
						// 0000 > 9000
						// 0000 > a000
						SOLVE1(0x100050009000d000, 0xf000f00000000000);
					}
					flag = 1;
				}
				if ((puzzle.Data() & uint64(0x00ff000000000000)) == uint64(0x0034000000000000)) {
					{
						// 0034 > 1234
						// 0000 > 0000
						// 0000 > 0000
						// 0000 > 0000
						SOLVE1(0x1234000000000000, 0x00ff000000000000);
					}
					{
						// 0034 > 0034
						// 0000 > 0078
						// 0000 > 0000
						// 0000 > 0000
						SOLVE1(0x0034007800000000, 0x00ff000000000000);
					}
					flag = 1;
				}
				if ((puzzle.Data() & uint64(0x00000000f000f000)) == uint64(0x000000009000d000)) {
					{
						// 0000 > 1000
						// 0000 > 5000
						// 9000 > 9000
						// d000 > d000
						SOLVE1(0x100050009000d000, 0x00000000f000f000);
					}
					{
						// 0000 > 0000
						// 0000 > 0000
						// 9000 > 9a00
						// d000 > de00
						SOLVE1(0x000000009a00de00, 0x00000000f000f000);
					}
					flag = 1;
				}
				if ((puzzle.Data() & uint64(0x000f000f00000000)) == uint64(0x0004000800000000)) {
					// 0004 > 0034
					// 0008 > 0078
					// 0000 > 0000
					// 0000 > 0000
					SOLVE1(0x0034007800000000, 0x000f000f00000000);
					flag = 1;
				}
				if ((puzzle.Data() & uint64(0x000000000000ff00)) == uint64(0x000000000000de00)) {
					// 0000 > 0000
					// 0000 > 0000
					// 0000 > 9a00
					// de00 > de00
					SOLVE1(0x000000009a00de00, 0x000000000000ff00);
					flag = 1;
				}
				if (flag == 1) {
					continue;
				}
				{
					SOLVE1(0x1200000000000000, 0);
				}
				{
					SOLVE1(0x0034000000000000, 0);
				}
				{
					SOLVE1(0x1000500000000000, 0);
				}
				{
					SOLVE1(0x000000009000d000, 0);
				}
				{
					SOLVE1(0x0004000800000000, 0);
				}
				{
					SOLVE1(0x000000000000de00, 0);
				}
			}
			currentStates.clear();
			currentStates.insert(nextStates.begin(), nextStates.end());
		}
		
		std::vector<Root>::iterator it = roots.begin();
		root = *it;
		it++;
		for (; it != roots.end(); it++) {
			if (it->size() < root.size()) {
				root = *it;
			}
		}
	}
	
END_OF_NAMESPACE

