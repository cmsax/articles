---
title: Focal Points in React.js
author: cmsax
date: 2020-07-22
---

## 基础回顾

### 生命周期

- 挂载
  - componentDidMount
  - componentWillMount
  - constructor
  - rendoer
- 更新
  - render
  - shouldComponentUpdate
  - componentDidUpdate
- 卸载
  - componentWillUnmount

### 事件处理

这样定义事件处理需要进行绑定：

```javascript
class A extends Component {
  constructor(props) {
    super(props);
    this.handleBClick = this.handleBClick.bind(this);
  }
  handleBClick() {
    //
  }
}
```

这样就不需要：

```javascript
class A extends Component {
  constructor(props) {
    //
    super(props);
  }
  handleBClick = () => {
    //
  };
}
```

### Props

React 中，props 作为函数的参数，可以使用任何类型的对象，包括 Component, Function, js 对象等。

### 数据分发与数据提升

单向数据流，父组件通过 props 向子组件分发数据，子组件是**纯函数**。

若子组件需要向父组件发送数据，使用父组件提供的 **props 中的函数**向父组件传递数据。

父组件可以通过 Context 向子组件广播数据，而避免通过 props 层层传递，一个简单的 demo：

```javascript
// 创建 Context
const ThemeContext = React.createContext("lightOption");

class A extends Component {
  render() {
    return (
      <ThemeContext.Provider value="dark">
        <Toolbar />
      </ThemeContext.Provider>
    );
  }
}

function Toolbar(props) {
  return (
    <div>
      <ThemedButton />
    </div>
  );
}

class ThemedButton extends Component {
  // 需要指定 contextType 静态
  static contextType = ThemeContext;
  render() {
    // 向上找最近的 Provider 并使用其值
    return <button theme={this.props.context} />;
  }
}
```

props 中可以传递 Component，因此也可以在顶部直接把数据包装到 Component 中然后传递给子组件，这样会讲逻辑提升到组件树的更高层次、使得高层组件更复杂。
除此之外，还可以使用 render props 来共享数据和代码逻辑。
