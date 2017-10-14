function [path ,avg_cost]= DTW(source_vector,target_vector)

source_vector = source_vector';
target_vector = target_vector';

[source_frame,dim] = size(source_vector);  % source
[target_frame,dim] = size(target_vector);  % target

% 算出各個frame之間的score
for i = 1:source_frame
    for j = 1:target_frame
        d(i,j) = sqrt(sum((source_vector(i,:)-target_vector(j,:)).^2));
    end
end

% 計算累加的總score
D = zeros(source_frame,target_frame);
D(1,1) = d(1,1);
for i = 2:source_frame
    D(i,1) = D(i-1,1) + d(i,1);
end
for i = 2:target_frame
    D(1,i) = D(1,i-1) + d(1,i);
end

for i = 2:source_frame
    for j = 2:target_frame
        D(i,j) = d(i,j) + min( [D(i-1,j),D(i-1,j-1),D(i,j-1)] );
    end
end

% 由終點trace back
cost = D(source_frame,target_frame);
t = source_frame;
r = target_frame; % 紀錄目前trace back到的位置
k = 1; % 走了幾步
path(:,1) = [source_frame;target_frame];  % 路徑

while((t+r) ~= 2)
    if (t-1)==0  % 走到邊邊
        r = r-1;
    elseif (r-1)==0 % 走到邊邊
        t = t-1;
    else % trace back
        [values,number] = min([D(t-1,r),D(t,r-1),D(t-1,r-1)]);
        switch number
            case 1
                t = t-1;
            case 2
                r = r-1;
            case 3
                t = t-1;
                r = r-1;
        end
    end
    k = k + 1;
    path = cat(2,[t;r],path);
end
avg_cost = cost/k;

% plot(path(1,:),path(2,:),'k');






