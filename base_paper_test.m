function [Precision Recall Fmeasure Accuracy]=base_paper_test(cromo1,mdl,max_len)


%max_len=100;
i=2;
 x=num2str(i);
y=num2str(i+max_len);
st =strcat('E',x,':BV',y);
[num1,txt1,raw1] = xlsread('RansomwareData.csv',st);
ar =fopen('IDS.txt');
 t = textscan(ar,'%s','delimiter','%, %?');
 
tr_ratio = 1;%str2num(get(handles.edit_ratio,'string'));
%------Invasive Weed optimization---------------

k = 13;%input('Enter Number of Clusters');
%k =2;
num_of_particle =9;%input('Enter Number of Particles');
iter = 1;%input('Enter Number of Iteration');
chgg = floor(k/2);
elements = size(raw1,2)-1;%+1;%size(img_name,1);
r=[];
training_data_size = max_len*tr_ratio;


%-----------------------------------------------------
count=1;
for j=1:size(raw1,1)

    for k=2:size(raw1,2)
   temp =raw1{j,k};
   feature_vect(j,k-1) = temp;
    end
    ch1 = t{1,1}(j,1);
    ttemp=ch1{1,1};
   feature_class{j,1}=ttemp(1,size(ttemp,2));
   semicolon = strfind(ttemp,';');
 srt=ttemp(1,semicolon(1,size(semicolon,2))-1);
   trt=str2num(srt);
   ttemp
   if trt>0
   classes_final(j,1)=1;
   else
       classes_final(j,1)=0;
   end
  
   count = count+1;
end

%-----------------------------------------------------
%cromo1 = r(Ii,:);

P = feature_vect;%P(1:training_data_size,:)';
Dt = classes_final';%T(1:training_data_size,:)';

%---------------------Normalization--------------------
final_feature=[];
for ik=1:size(cromo1,1)
    soll = cromo1(ik,:);
    
for i=1:size(P,1)
count=1; 
    for j=1:size(P,2)
   
        if soll(1,j)==1 
            final_feature(1,count)=j;
        PP(i,count)=P(i,j);%-miin)/(maax-miin);
        count=count+1;
        end
    end
end
end
A=1; %00
C=2; %01
G=3; %10
T=4; %11

for i=1:size(PP,1)
count=1; 
    for j=1:size(PP,2)-1
   
        if PP(i,j)==0 && PP(i,j+1)==0
        PP_input(i,j)=A;%-miin)/(maax-miin);
        elseif PP(i,j)==0 && PP(i,j+1)==1
        PP_input(i,j)=C;
        elseif PP(i,j)==1 && PP(i,j+1)==0
        PP_input(i,j)=G;
        elseif PP(i,j)==1 && PP(i,j+1)==1
        PP_input(i,j)=T;
        end
    end
end
%for i=1:15
P=[];
P=PP_input';
%------------------------------------------------------
TP=0;
TN=0;
FP=0;
FN=0;
pos=0;
ypred = predict(mdl,P');
for i=1:size(P,2)
    Y=round(ypred(i,1));
%     if yy>=0.35
%         Y=1;
%     else
%         Y=0;
%     end
    X=(Dt(1,i));
 if Y==1 && (Dt(1,i))==1
 
     TP=TP+1;
 elseif Y==1 && (Dt(1,i))==0
 
     TN=TN+1;
 elseif Y==0 && (Dt(1,i))==1
 
     FP=FP+1;
 else
     FN=FN+1;
 end
end
d=sum(Dt)
Precision =TP/(TP+FP)
Recall =TP/(TP+FN)
Fmeasure =2*Recall*Precision/(Precision+Recall)
Accuracy=(TP+TN)/(TP+TN+FP+FN)

end

