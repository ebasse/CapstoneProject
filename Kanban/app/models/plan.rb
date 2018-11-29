class Plan
    PLANS = [:premium]
    
    def self.options
        PLANS.map { |plan| [plan.capitalize, plan] }
    end
end