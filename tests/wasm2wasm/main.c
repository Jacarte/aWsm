
static int __global_1;

int f(int a, int b){

	return ((a << (b & 31)) | (a >> ((-b) & 31)));
}

int g(int a, int b){

	return ((a >> (b & 31)) | (a << ((-b) & 31)));
}


float h(float a){

	return floor(a);
}


int linear_mem[100];

int i(int a, int b){
	linear_mem[a] = b;
	return 0;
}


int j(){
	return __global_1;
}
