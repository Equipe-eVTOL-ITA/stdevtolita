#pragma once

class PidController {
public:
    PidController(double kp, double ki, double kd);
    
    void setTarget(double target);
    double compute(double currentValue);
    
    void setKp(double kp);
    void setKi(double ki);
    void setKd(double kd);

private:
    double kp_; // Proportional gain
    double ki_; // Integral gain
    double kd_; // Derivative gain
    double target_; // Target value
    double integral_; // Integral term
    double previousError_; // Previous error for derivative calculation
};