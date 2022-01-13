#include<iostream>
#include<vector>
#include<ctime>
#include<cstdlib>
#include"BarrierOption.h"


using std::vector;
using std::cout;
using std::cin;

int main(){

	// set the seed
	srand( time(NULL) );

	//create a new instance of class
	BarrierOption myBarrier(102, 126, 105, 100, 0.22, 0.05, 0.5);

	// Iterate over all the elements.
	// myBarrier.printPath();

	//get arithmetic means
	cout << "max price = " << myBarrier.getmax() <<"\n";


	//get last price of underlying
	cout << "Last price of underlying = " << myBarrier.thisPath.back() << "\n";

	//run Monte Carlo to obtain theoretical price of Asian options
	cout << "Price of myBarrier Up-and-In Put = " << myBarrier.getBarrierUpandInPutPrice(1) << "\n";



	//check whether the Data Generating Process runs correctly
	//(is the expected price and volatility of underlying close to option parameters?)
	
	return 0;
}

