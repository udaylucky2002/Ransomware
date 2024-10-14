function [net_ff cromo1]=genetic_modify_selection(max_len)


%max_len=100;
i=2;
 x=num2str(i);
y=num2str(i+max_len);
st =strcat('E',x,':CV',y);
[num1,txt1,raw1] = xlsread('RansomwareData.csv',st);
ar =fopen('IDS.txt');
 t = textscan(ar,'%s','delimiter','%, %?');
 
tr_ratio = 1;%str2num(get(handles.edit_ratio,'string'));
%------Invasive Weed optimization---------------
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

k = 13;%input('Enter Number of Clusters');
%k =2;
num_of_particle =3;%input('Enter Number of Particles');
iter = 1;%input('Enter Number of Iteration');
chgg = floor(k/2);
elements = size(raw1,2)-1;%+1;%size(img_name,1);
r=[];
training_data_size = max_len*tr_ratio;
for i=1:num_of_particle

    items = randi([20 elements],[1,1]);
    x = zeros(1,elements);
    count=1;
    while count<=items
        xt = randi([1 elements],[1,1]);
        x(1,xt)=1;
        count=count+1;
    end
    r=[r;x];
end
%r = unique(randi(k,[num_of_particle,k]),'rows'); % in this matrix row represent particle and colum represent centroid
%r=unique(r,'column');



%-----------------------------------------------------


%r=unique(r,'column');
new_nests=3;
counter=0;
cromo1=r;
while counter < iter%for j=1:size(r,1)%(1,:)
 counter=counter+1;
 cromo1_new=cromo1;
fitness=text_fitness_modify(cromo1,raw1,max_len,training_data_size,classes_final,feature_vect);
[Cs Is]=sort(fitness);
for k=1:size(cromo1,1)
        
            counters=1;
            while counters<=new_nests%x_t(m,2)
   
        %tr = randi([st_p st_e],1,1);
 
        r_pos = randi(elements,1,1);
     
    cromo1_new(k,r_pos) =cromo1_new(Is(1,1),r_pos);
        
        counters=counters+1;
        
            end
            
end
       %-----------------------
        fitness_new=text_fitness_modify(cromo1_new,raw1,max_len,training_data_size,classes_final,feature_vect);
        
        for k=1:size(cromo1,1)
           if  fitness(k,1)<=fitness_new(k,1)
            cromo1(k,:)=cromo1_new(k,:);
           end
        end
        cromo1_new=[];
end

fitness=text_fitness_modify(cromo1,raw1,max_len,training_data_size,classes_final,feature_vect);
[Cc Ii]=max(fitness);
st_time=tic;
cromo1 = r(Ii,:);

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
net = newff(P,Dt,[5,7]);
net.trainParam.epochs = 400;
net.trainParam.goal = 0.01;
net.trainParam.show = 1;
net.trainParam.mc = 0.9;
net.trainParam.max_fail = 10000;
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.1;
net.divideParam.testRatio = 0.1;
tic;
net_ff = train(net,P,Dt);
%Y = round(sim(net_ff,P));

pos=0;
for i=1:size(P,2)
feature_vect_temp_1=P(:,i);

 Y = round(sim(net_ff,feature_vect_temp_1));

 if Y==floor(Dt(1,i))
 
     pos=pos+1;
 end
end

detection_accuracy = pos/i;
detection_accuracy
final_time = toc(st_time);

final_time

end

