void move(int x, int y) {}

void foo() {}

void foo4(x) {}

void foo5(int? x) {}

void foo1(int x) {}

void foo2(int x,) {}

void foo3(int x,int y,int z,) {}


//正则1:  \(((\s+)?\w+(\s+)?\w+(\s+)?,?)*(\s+)?\)
//正则2:  \(((\s+)?(\w+\?)?(\s+)?\w+(\s+)?,?)*(\s+)?\)