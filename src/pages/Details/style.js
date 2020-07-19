import {StyleSheet} from 'react-native';

const style = StyleSheet.create({
    container:{
        flex: 1,
        backgroundColor: '#1F1A38',
        justifyContent: 'center',
    },
    header:{
        flexDirection: 'row',
        justifyContent: 'space-between',
        width: "100%", 
        position: "absolute",
        top: 0,
        borderBottomWidth: 3,
        borderColor: '#110e1F',
        paddingHorizontal: "6%",
        paddingVertical: "4%",
    },
    details:{
        paddingHorizontal: "3%",
    },
    topic:{
        color: "#979797",
        lineHeight: 50,
        fontSize: 20
    },

    action:{
        color: "#979797",
        paddingTop: 30,
        lineHeight: 50,
        fontSize: 20
    }
});

export default style