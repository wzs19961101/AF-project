#include <Rcpp.h>
#include<vector>
#include<ctime>
#include<cstdlib>
#include"BarrierOption.h"


using std::vector;
using std::cout;
using std::cin;
using namespace Rcpp;

// [[Rcpp::export]]
double getBarrierUpandInPutPrice(
    double b,
    int nInt,
    double strike,
    double spot,
    double vol,
    double r,
    double expiry,
    int nReps){

	// set the seed
	srand( time(NULL) );

	//create a new instance of class
	BarrierOption myBarrier(b, nInt, strike, spot, vol, r, expiry);



	return myBarrier.getBarrierUpandInPutPrice(nReps);
}

