private static func ArrayPushAll(target: array<IScriptable>, items: array<IScriptable>) -> Void {
    let i = 0;
    while (i < ArraySize(items)) {
        ArrayPush(target, items[i]);
        i += 1;
    }
}