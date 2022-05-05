
import SwiftUI

struct CustomSheet<Content: View>: View {
    
    @Environment(\.horizontalSizeClass) private var horizontal
    let title: LocalizedStringKey
    @Binding var isPresented: Bool
    let content: () -> Content
    
    init(title: LocalizedStringKey, isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self._isPresented = isPresented
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(title)
                    .font(.title2.bold())
                Spacer()
                Button {
                    withAnimation(.spring()) {
                        isPresented = false
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray6))
                            .frame(width: 32, height: 32)
                        Image(systemName: "xmark")
                            .font(.caption.weight(.semibold))
                            .foregroundColor(.gray)
                    }
                }

            }
            content()
        }
        .padding(horizontal == .compact ? 20 : 40)
        .padding(.bottom, horizontal == .compact ? 20 : 0)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.theme.groupedBackground)
        )
        .frame(maxWidth: horizontal == .regular ? 350 : .infinity )
        .padding()
        .padding(.bottom, 100)
    }
}

struct CustomSheetViewModifier<InnerContent: View>: ViewModifier {
    
    @Environment(\.horizontalSizeClass) private var horizontal
    let title: LocalizedStringKey
    @Binding var isPresented: Bool
    let innerContent: () -> InnerContent
    
    init(title: LocalizedStringKey, isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> InnerContent) {
        self.title = title
        self._isPresented = isPresented
        self.innerContent = content
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isPresented ? 4 : 0)
            ZStack(alignment: horizontal == .regular ? .center : .bottom) {
                if isPresented {
                    Color.black.opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isPresented = false
                            }
                        }
                        .transition(.opacity)
                    
                    CustomSheet(title: title, isPresented: $isPresented) {
                        innerContent()
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

extension View {
    func customSheet<Content: View>(title: LocalizedStringKey, isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.modifier(CustomSheetViewModifier(title: title, isPresented: isPresented, content: content))
    }
}
