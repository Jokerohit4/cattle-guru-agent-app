class Solution {
public:

      int dhsodb(vector<int>& pkt, vector<int>& pkt2, int k)
      {
        int solution=0;
          if(pkt.size()==k){
              sort(pkt.begin(),pkt.end());
              int addup=0;
              for(int i:pkt)addup+=i;
              return addup;
          }
          priority_queue<pair<int,int>>kpt;
          int i = 0;
          while(i<pkt.size()){
              kpt.push({pkt[i]-pkt2[i],i});
              i++;
          }
          for(;!kpt.empty();){
              if(k<=0) solution+=pkt2[kpt.top().second];
              else {solution+=pkt[kpt.top().second]; k--;}
              kpt.pop();
          }
          return solution;
      }
    int miceAndCheese(vector<int>& r1, vector<int>& r2, int k) {
        return dhsodb(r1,r2,k);
           
    }
};