//
// Created by Yangyang Wang on 9/19/18.
//a big matrix calculation which need more than one day using python, but this only 4 minutes

#include <iostream>
#include<fstream>
#include<sstream>
#include <vector>
#include <cmath>
using namespace std;
typedef vector<double> Vector;
typedef vector<Vector> Matrix;

int main() {
//int select_num=8228;
    static int size=3767;
    ifstream myFile;
    myFile.open("../data/for_c++_calculation/sentiment_line_for_c2.csv");
    Matrix M;
    while (myFile.good()) {
        string line;
        getline(myFile, line);
        Vector ROW;
        istringstream iss(line);
        string value;
        while (getline(iss, value, ',')) {
            /* HERE I TAKE THE VALUES OF THE .CSV MATRIX AS C-STRINGS
               AND CONVERT THEM AS FLOATS                          */
            ROW.push_back(atof(value.c_str()));
        }
        M.push_back(ROW);

    }
    cout<<M.size()<<endl;
    cout<<M[0].size()<<endl;

    static float res[3767][3767];//stack overflow! so use static
    for (int i=0; i < 3767; i++) {
        for (int j=0; j <=i; j++) {
            double dot=0;
            double denom_a=0;
            double denom_b=0;
            for (int num=0;num<99;num++)
            {
                dot += M[i][num] * M[j][num] ;
                denom_a += M[i][num] * M[i][num] ;
                denom_b += M[j][num] * M[j][num] ;
            }
            double sim=dot /(sqrt(denom_a) * sqrt(denom_b));
            res[i][j]=sim;
            res[j][i]=sim;
        }

    }
    std::ofstream out("../data/for_c++_calculation/sentiment_line_similarities2.csv");

    for (auto& row : res) {
        for (auto col : row)
            out << col <<',';
        out << '\n';
    }
    return 0;

}
