#include<iostream>
#include<cmath>
#include"getOneGaussianByBoxMueller.h"
#include"BarrierOption.h"


//definition of constructor
BarrierOption::BarrierOption(
	double b_,
	int nInt_,
	double strike_,
	double spot_,
	double vol_,
	double r_,
	double expiry_){
		b = b_;
		nInt = nInt_;
		strike = strike_;
		spot = spot_;
		vol = vol_;
		r = r_;
		expiry = expiry_;
		generatePath();
}

//method definition
void BarrierOption::generatePath(){
	double thisDrift = (r * expiry - 0.5 * vol * vol * expiry) / double(nInt);
	double cumShocks = 0;
	thisPath.clear();

	for(int i = 0; i < nInt; i++){
		cumShocks += (thisDrift + vol * sqrt(expiry / double(nInt)) * getOneGaussianByBoxMueller());
		thisPath.push_back(spot * exp(cumShocks));
	}
}

//method definition
double BarrierOption::getmax(){

	double runningmax = strike;

	for(int i = 0; i < nInt; i++){
	
		if(thisPath[i+1] >= runningmax )
		{
			runningmax = thisPath[i+1];
		}
		
	}

	return runningmax;
}


//method definition
void BarrierOption::printPath(){

	for(int i = 0;  i < nInt; i++){

		std::cout << thisPath[i] << "\n";

	}

}

//method definition
double BarrierOption::getBarrierUpandInPutPrice(int nReps){

	double rollingSum = 0.0;
	double thismax;

	for(int i = 0; i < nReps; i++){
		generatePath();
		thismax=getmax();
		double thisPayoff = strike - thisPath.back() ;
		rollingSum += ((thismax >= b)&(thisPayoff > 0)) ? thisPayoff : 0;
	}

	return exp(-r*expiry)*rollingSum/double(nReps);

}


