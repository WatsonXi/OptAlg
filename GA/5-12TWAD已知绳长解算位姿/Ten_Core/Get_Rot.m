%% Get_Rot.m
    % Get_Rot.m cal a rotage matrix, only when input the state(whole)
    % 4/22 version 1.0
    
    function R = Get_Rot(s)
       if mod(size(s,1),6) ~= 0
           error('state wrong');
       end
       % Taking the angle; per verterae information save as a vertor of s
       for i = 1 : (size(s,1) / 6)
            STATE(:, i) = s(((i-1) * 6 + 4) :((i-1) * 6 + 6)); 
       end
%        STATE;
       % Calculate R matrix
%        R = cell(3,3 * size(STATE,2));
%             t = zeros(3,1);
%             t = STATE(:,j);     % assign
            t = STATE;
            Rz = [  cos(t(1)),  -sin(t(1)), 0;
                    sin(t(1)),  cos(t(1)),  0;
                    0           0           1];
            Ry = [  cos(t(2)),  0,  sin(t(2));
                    0,          1,  0;
                    -sin(t(2)), 0,  cos(t(2))];
            Rx = [  1,  0,          0;
                    0,  cos(t(3)),  -sin(t(3));
                    0,  sin(t(3)),  cos(t(3))];    
            R = Rz * Ry * Rx;
                    % debugging           
    end