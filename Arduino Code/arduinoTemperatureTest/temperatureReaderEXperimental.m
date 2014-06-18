%% Temperature Reader X

% This is not a working program at all, but simply a place for eXperimental
% code, which is not worthy of creating a whole new Temperature Reader
% iteration for, yet still warrents being saved for later.


% This is a primative pause/stop function. It utilizes the external
% function getkey to read a user's input, and does things in response. It
% doesn't work because getkey currently waits for a user's input before
% continuing. If someone wants to rectify that, it would be excellent.

keypress = getkey;
    
    if (keypress == 32)
        keypress = 0;
        disp('Paused. Press Spacebar to continue.');
        while (keypress ~= 0); end
    end
    
    if (keypress == 27)
        keypress = 0;
        clc;
        disp('You want to quit? Press escape again, to be sure. Or press Spacebar to continue recording.');
        if(keypress == 27)
            keypress = 0;
            clc;
            disp('Really? This is important data. You are positive you want to stop recording? Press Escape one more time, just to be sure.');
            if(keypress == 27)                
                disp('Wow, you are dedicated. Fine, quitting program now. Not my fault if you fail the lab.');
                pause(1000);
                clc;
                disp('Having second thoughts now? Too late!');
                break;
            end
        end
    elseif (keypress == 32)
        clc;
        disp('Good choice');
    end