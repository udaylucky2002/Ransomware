function [net_ff cromo1]=genetic_modify_moth_selection(max_len)


max_len=1000;
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
%-----------------------------------------------------

elements=size(r,2);
iter=1;
% Main loop
Moth_pos=r;
ub = max(elements);
lb =(elements)/4;
Max_iteration=5;
Iteration=1;
N=size(r,1);
while Iteration<Max_iteration+1
    lb
    % Number of flames Eq. (3.14) in the paper
    Flame_no=round(N-Iteration*((N-1)/Max_iteration));
    
    for i=1:size(Moth_pos,1)
        
        % Check if moths go out of the search spaceand bring it back
        Flag4ub=sum(Moth_pos(i,:));%>ub;
        Flag4lb= size(r,2)-Flag4ub;
        if Flag4ub > ub
            ppos =randi(elements,1,1);
        
            Moth_pos(i,ppos)=0;
        
        elseif Flag4lb<lb
        
            ppos =randi(elements,1,1);
        
            Moth_pos(i,ppos)=1;
        
        end
            %(Moth_pos(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        % Calculate the fitness of moths
        fitness=text_fitness_modify(Moth_pos(i,:),raw1,max_len,training_data_size,classes_final,feature_vect);
        %fitness=text_fitness_moth(Moth_pos(i,:),raw1,max_len,training_data_size,classes_final,feature_class_data_final);

        [Cc Ii]=max(fitness);

        Moth_fitness(1,i)=Cc;%text_fitness(Moth_pos(i,:),list_word_class);  
        
    end
       %Moth_fitness=text_fitness(cromo1,list_word_class);  
    if Iteration==1
        % Sort the first population of moths
        [fitness_sorted I]=sort(Moth_fitness);
        sorted_population=Moth_pos(I,:);
        
        % Update the flames
        best_flames=sorted_population;
        best_flame_fitness=fitness_sorted;
    else
        
        % Sort the moths
        double_population=[previous_population;best_flames];
        double_fitness=[previous_fitness best_flame_fitness];
        
        [double_fitness_sorted I]=sort(double_fitness);
        double_sorted_population=double_population(I,:);
        
        fitness_sorted=double_fitness_sorted(1:N);
        sorted_population=double_sorted_population(1:N,:);
        
        % Update the flames
        best_flames=sorted_population;
        best_flame_fitness=fitness_sorted;
    end
    
    % Update the position best flame obtained so far
    Best_flame_score=fitness_sorted(1);
    Best_flame_pos=sorted_population(1,:);
      
    previous_population=Moth_pos;
    previous_fitness=Moth_fitness;
    
    % a linearly dicreases from -1 to -2 to calculate t in Eq. (3.12)
    a=-1+Iteration*((-1)/Max_iteration);
    
    for i=1:size(Moth_pos,1)
        
        for jj=1:10
            j=randi(elements,1,1);
            if i<=Flame_no % Update the position of the moth with respect to its corresponsing flame
                
                % D in Eq. (3.13)
                distance_to_flame=abs(sorted_population(i,j)-Moth_pos(i,j));
                b=1;
                t=(a-1)*rand+1;
                
                % Eq. (3.12)
                dd= distance_to_flame*exp(b.*t).*cos(t.*2*pi)+sorted_population(i,j);
                if dd>1 
                Moth_pos(i,j)=1;
                else
                    Moth_pos(i,j)=0;
                end
            end
            
            if i>Flame_no % Upaate the position of the moth with respct to one flame
                
                % Eq. (3.13)
                distance_to_flame=abs(sorted_population(i,j)-Moth_pos(i,j));
                b=1;
                t=(a-1)*rand+1;
                
                % Eq. (3.12)
                dd=distance_to_flame*exp(b.*t).*cos(t.*2*pi)+sorted_population(Flame_no,j);
                 if dd>1 
                Moth_pos(i,j)=1;
                else
                    Moth_pos(i,j)=0;
                end
            end
            
        end
        
    end
    
    
    Iteration=Iteration+1; 
end

fitness=text_fitness_modify(Moth_pos,raw1,max_len,training_data_size,classes_final,feature_vect);



% %r=unique(r,'column');
% new_nests=3;
% counter=0;
% cromo1=r;
% while counter < iter%for j=1:size(r,1)%(1,:)
%  counter=counter+1;
%  cromo1_new=cromo1;
% fitness=text_fitness_modify(cromo1,raw1,max_len,training_data_size,classes_final,feature_vect);
% [Cs Is]=sort(fitness);
% for k=1:size(cromo1,1)
%         
%             counters=1;
%             while counters<=new_nests%x_t(m,2)
%    
%         %tr = randi([st_p st_e],1,1);
%  
%         r_pos = randi(elements,1,1);
%      
%     cromo1_new(k,r_pos) =cromo1_new(Is(1,1),r_pos);
%         
%         counters=counters+1;
%         
%             end
%             
% end
%        %-----------------------
%         fitness_new=text_fitness_modify(cromo1_new,raw1,max_len,training_data_size,classes_final,feature_vect);
%         
%         for k=1:size(cromo1,1)
%            if  fitness(k,1)<=fitness_new(k,1)
%             cromo1(k,:)=cromo1_new(k,:);
%            end
%         end
%         cromo1_new=[];
% end
% 
% fitness=text_fitness_modify(cromo1,raw1,max_len,training_data_size,classes_final,feature_vect);
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

