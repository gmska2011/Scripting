import sys
import random
from PySide2.QtWidgets import (QApplication, QLabel, QPushButton,
                               QVBoxLayout, QWidget)
from PySide2.QtCore import Slot, Qt
from PySide2 import QtCore, QtGui, QtWidgets

class MyWidget(QWidget):
    def __init__(self):
        QWidget.__init__(self)

        self.hello = ["Hallo Welt", "你好，世界", "Hei maailma",
            "Hola Mundo", "Привет мир"]

        self.button = QPushButton("Click me!")
        self.text = QLabel("Hello World")
        self.text.setAlignment(Qt.AlignCenter)

        self.user_photo = ["./photo/Абрамов Олег Львович.jpg", "./photo/Яковенко Александр Михайлович.jpg"]
        self.pixmap = QtGui.QPixmap("./photo/Абрамов Олег Львович.jpg")
        self.label = QtWidgets.QLabel()
        self.label.setPixmap(self.pixmap)
#        self.label.show()
        self.layout = QVBoxLayout()
        self.layout.addWidget(self.text)
        self.layout.addWidget(self.button)
        self.layout.addWidget(self.label)
        self.setLayout(self.layout)

        # Connecting the signal
        self.button.clicked.connect(self.magic)

    @Slot()
    def magic(self):
        self.text.setText(random.choice(self.hello))
        self.label.setPixmap(random.choice(self.user_photo))

if __name__ == "__main__":
    app = QApplication(sys.argv)

    widget = MyWidget()
    widget.resize(200, 300)
    widget.show()

    sys.exit(app.exec_())