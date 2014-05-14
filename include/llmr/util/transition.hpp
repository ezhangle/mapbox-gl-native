#ifndef LLMR_UTIL_TRANSITION
#define LLMR_UTIL_TRANSITION

#include <llmr/util/noncopyable.hpp>
#include <llmr/util/time.hpp>

namespace llmr {
namespace util {

class transition : private noncopyable {
public:
    enum state {
        running,
        complete
    };

    inline transition(time start, time duration)
        : start(start),
          duration(duration) {}

    inline float progress(time now) const {
        return (float)(now - start) / duration;
    }

    virtual state update(time now) const = 0;
    virtual ~transition();

protected:
    const time start, duration;
};

class ease_transition : public transition {
public:
    // Disable automatic casts.
    template <typename T1, typename T2>
    inline ease_transition(double from, double to, double& value, T1 start, T2 duration) = delete;

    // Actual constructor.
    ease_transition(double from, double to, double& value, time start, time duration);
    state update(time now) const;

private:
    const double from, to;
    double& value;
};

template <typename T>
class timeout : public transition {
public:
    // Disable automatic casts.
    template <typename T1, typename T2>
    inline timeout(T final_value, T& value, T1 start, T2 duration) = delete;

    // Actual constructor.
    timeout(T final_value, T& value, time start, time duration)
        : transition(start, duration),
          final_value(final_value),
          value(value) {}

    state update(time now) const {
        if (progress(now) >= 1) {
            value = final_value;
            return complete;
        } else {
            return running;
        }
    }

private:
    const T final_value;
    T& value;
};

}
}

#endif