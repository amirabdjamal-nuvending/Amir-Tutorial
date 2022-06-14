class Dog:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def speak(self):
        print("Hi I am", self.name, 'and I am', self.age, 'years old')

    def talk(self):
        print("Bark")

class Cat(Dog):
    def __init__(self, name, age, birthday_year):
        super().__init__(name, age)
        self.birthday_year = birthday_year

    def talk(self):
        print("Meow")

Tim = Cat("Tim", 20, 1996)

# Tim.talk()

y = Tim.talk()
print(y)
