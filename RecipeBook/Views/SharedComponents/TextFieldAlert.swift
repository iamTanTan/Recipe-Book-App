//
//  TextFieldAlert.swift
//  RecipeBook
//
//  Created by Tanner Rackow on 10/27/22.
//


import SwiftUI

struct TextFieldAlert: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    @Binding var text: String
    let placeholder: String
    let action: (String) -> Void
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
                .disabled(isPresented)
            if isPresented {
                VStack {
                    Text(title).font(.headline).padding()
                    TextField(placeholder, text: $text).textFieldStyle(.roundedBorder).padding()
                    Divider()
                    HStack{
                        Spacer()
                        Button(role: .destructive) {
                            withAnimation {
                                isPresented.toggle()
                            }
                        } label: {
                            Text("Cancel")
                        }
                        Spacer()
                        Divider()
                        Spacer()
                        Button() {
                            action(text)
                            withAnimation {
                                isPresented.toggle()
                            }
                        } label: {
                            Text("Done")
                        }
                        Spacer()
                    }
                }
                .background(.background)
                .frame(width: 300, height:190)
                .cornerRadius(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.quaternary, lineWidth: 1)
                }
            }
        }.zIndex(1)
    }
}

extension View {
    public func textFieldAlert(
        isPresented: Binding<Bool>,
        title: String,
        text: Binding<String>,
        placeholder: String = "",
        action: @escaping (String) -> Void
    ) -> some View {
        self.modifier(TextFieldAlert(isPresented: isPresented, title: title, text: text, placeholder: placeholder, action: action))
    }
}
