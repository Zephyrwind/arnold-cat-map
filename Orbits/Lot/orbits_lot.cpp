#include <fstream>
//#include <iostream>

using namespace std;

int Orbita(int i, int j, int N){

	int t=1;
	int x_old=i+j;
	int y_old=i+2*j;
	int x_new, y_new;

	if(x_old>=N)	x_old=x_old%N;
	if(y_old>=N)	y_old=y_old%N;

	while(t<3*N){

		int x_new=x_old+y_old;
		int y_new=x_old+2*y_old;

		if(x_new>=N)	x_new=x_new%N;
		if(y_new>=N)	y_new=y_new%N;

		if(x_new==i && y_new==j){

			if(x_new+y_new==0)	return t;

			return t+1;
		}	

		x_old=x_new;
		y_old=y_new;
		t=t+1;
	}

	return 0;
}

int main(){

	int Nmax=101;
	int p;

	for(int N=2;N<=Nmax;N++){

	char file[100]={};
	sprintf(file,"orbit %03d.txt",N);
	ofstream output(file);

		for(int y=0;y<N;y++){

			for(int x=0;x<N;x++){

				p=Orbita(x,y,N);
				output<< p<<'\t';  
			}

			output<<'\n';
		}

	output.close();
	}

return 0;
}