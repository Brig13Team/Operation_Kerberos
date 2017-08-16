#pragma once

#ifndef SINGLETON
#define SINGLETON
template <class  T>
class singleton {
public:
    static T* getInstance();

protected:
    static T* instance;
    singleton() { instance = static_cast <T*> (this); }
};

template <class  T>
typename T* singleton<T>::instance = 0;

template <class T>
T* singleton<T>::getInstance() {
    if (instance == 0) {
        try {
            singleton<T>::instance = new T();
        } catch (std::exception& e) {
            LOG(ERROR) << "Error creating singleton: " << e.what();
        }
    }
    return instance;
}
#endif
