#include<vector>

class BarrierOption{
public:

	//constructor
	BarrierOption(
		double b_,
		int nInt_,
		double strike_,
		double spot_,
		double vol_,
		double r_,
		double expiry_
		);

	//destructor
	~BarrierOption(){};

	//methods
	void generatePath();
	double getmax();
	void printPath();
	double getBarrierUpandInPutPrice(int nReps);

	
	//members
	std::vector<double> thisPath;
	double b;
	int nInt;
	double strike;
	double spot;
	double vol;
	double r;
	double expiry;

};
