classdef Stack < handle
    % Simple stack class
    % Takes first element for the constuctor
    
    properties
        StackArray
        StackPosition
    end
    
    methods
        function stack = Stack(FirstElement)
            if nargin > 0  % If the first element is given         
                stack.StackArray = FirstElement;
                stack.StackPosition = 1;
            end
        end
        function node = pop(self)
            node = self.StackArray(self.StackPosition);
            self.StackPosition = self.StackPosition - 1 ;  % Iterate on stack
        end
        function [] = push(self, element)
            self.StackPosition = self.StackPosition +1;
            self.StackArray(self.StackPosition) = element;
        end
    end
    
end

