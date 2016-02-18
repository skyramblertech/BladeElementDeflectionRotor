function phi = phialpha(alpha,cl,cd)

% zero-lift angle.
a0 = interp1(cl,alpha,0);
% zero-lift drag.
cd0 = interp1(alpha,cd,a0);
% deflection drag.
cdi = cd - cd0;

n = max(size(alpha));
phi = zeros(n,1);
stall = zeros(n,1);
flag = 0;
stallindex = 0;
for i = 1:n
    % check for stall
    if(i > 1)
        if (cl(i) < cl(i-1))
            if (flag == 0)
                stallindex = i;  
            end
            flag = 1;
        end
    end
    if(flag > 0)
        stall(i) = 1;
    end
    % calculate phi
    if cdi(i) == 0
        phi(i) = 0;
    else
        phi(i) = 2*acotd(cl(i)/cdi(i));
    end
end


% fitting for stall
if stallindex > 0 % if stall exists
    sr = 1:(stallindex-1); % stall range
    for i = 1:n
        if stall(i) > 0
            i
            % corresponding pre-stall quantities.
            pa = interp1(cl(sr),alpha(sr),cl(i));
            pphi = interp1(alpha(sr),phi(sr),pa);
            % new phi value.
            phi(i) = pphi;
        end
    end
end

