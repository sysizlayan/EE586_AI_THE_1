classdef Queue < handle
    % Simple queue class
    % Takes first element to constructor
    
    properties
        QueueArray
        QueuePosition
    end
    
    methods
        function queue = Queue(FirstElement)
            if nargin > 0  % If the first element is given         
                queue.QueueArray = FirstElement;
                queue.QueuePosition = 1;
            else
                queue.QueueArray = [];
                queue.QueuePosition = 1;
            end
        end
        function Node = pop(self)
            Node = self.QueueArray(self.QueuePosition);
            self.QueuePosition = self.QueuePosition+1; % Iterate on queue
        end
        function [] = push(self, element)
            self.QueueArray(length(self.QueueArray) + 1) = element;
        end
    end
    
end

