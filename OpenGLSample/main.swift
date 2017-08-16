//
//  main.swift
//  OpenGLSample
//
//  Created by Hiroki Ishiura on 2017/08/16.
//  Copyright (c) 2017 Hiroki Ishiura. All rights reserved.
//

import Foundation
import libglfw3

glfwSetErrorCallback { (error, description) in
	print(String(cString: description!))
}
if glfwInit() == 0 {
	exit(1)
}
defer {
	glfwTerminate()
}

guard let window = glfwCreateWindow(640, 400, "OpenGL Sample", nil, nil) else {
	exit(1)
}
defer {
	glfwDestroyWindow(window)
}

glfwMakeContextCurrent(window)
glfwSetKeyCallback(window) { (window, key, scancode, action, modifier) in
	if key == GLFW_KEY_ESCAPE && action == GLFW_PRESS {
		glfwSetWindowShouldClose(window, GL_TRUE)
	}
}

while glfwWindowShouldClose(window) == 0 {

	var width: Int32 = 0
	var height: Int32 = 0
	glfwGetFramebufferSize(window, &width, &height)
	let ratio = Float(width) / Float(height)
	glViewport(0, 0, width, height)

	glClear(GLbitfield(GL_COLOR_BUFFER_BIT))

	glMatrixMode(GLenum(GL_PROJECTION))
	glLoadIdentity()
	glOrtho(GLdouble(-ratio), GLdouble(ratio), -1.0, 1.0, 1.0, -1.0)

	glMatrixMode(GLenum(GL_MODELVIEW))
	glLoadIdentity()
	glRotatef(GLfloat(glfwGetTime() * 50.0), 0.0, 0.0, 1.0)
	glBegin(GLenum(GL_TRIANGLES))
	glColor3f(1.0, 0.0, 0.0)
	glVertex3f(-0.6, -0.4, 0.0)
	glColor3f(0.0, 1.0, 0.0)
	glVertex3f(0.6, -0.4, 0.0)
	glColor3f(0.0, 0.0, 1.0)
	glVertex3f(0.0, 0.6, 0.0)
	glEnd()

	glfwSwapBuffers(window)
	glfwPollEvents()
}

exit(0)

// EOF
